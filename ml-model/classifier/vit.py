import numpy as np
import torch
import torch.nn as nn
import torch.optim as optim
from torch.utils.data import Dataset, DataLoader
import torchvision.transforms as transforms
from timm import create_model
from sklearn.preprocessing import LabelEncoder
import os
import matplotlib.pyplot as plt

# Custom Dataset
class FootprintDataset(Dataset):
    def __init__(self, npz_path, transform=None):
        data = np.load(npz_path)
        self.images = data['X'].astype(np.float32)  # Ensure float32 for tensors
        self.labels = data['Y']

        # Normalize images to [0,1]
        self.images /= 255.0  

        # Encode labels if needed
        self.encoder = LabelEncoder()
        self.labels = self.encoder.fit_transform(self.labels)

        self.transform = transform

    def __len__(self):
        return len(self.images)

    def __getitem__(self, idx):
        image = self.images[idx]
        label = self.labels[idx]

        # Convert image to PyTorch tensor
        image = torch.tensor(image).permute(2, 0, 1)  # Convert to (C, H, W)

        if self.transform:
            image = self.transform(image)

        return image, label

# Normalize images only
train_transform = transforms.Compose([
    transforms.Normalize(mean=[0.5], std=[0.5])  
])

test_transform = transforms.Compose([
    transforms.Normalize(mean=[0.5], std=[0.5])
])

# Load Vision Transformer (ViT) model
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
model = create_model("vit_base_patch16_224", pretrained=True, num_classes=4)
model = model.to(device)

# Define loss function and optimizer
criterion = nn.CrossEntropyLoss()
optimizer = optim.AdamW(model.parameters(), lr=3e-4, weight_decay=1e-4)

# Early stopping setup
early_stopping_patience = 2
best_val_loss = float("inf")
patience_counter = 0
best_model_path = "model/best_model.pth"

# Ensure the 'model' directory exists
os.makedirs("model", exist_ok=True)

# Training function with early stopping and model restoration
def train_model(model, train_loader, val_loader, epochs=10):
    global best_val_loss, patience_counter

    train_losses, val_losses = [], []

    for epoch in range(epochs):
        model.train()
        total_loss, correct = 0, 0

        for images, labels in train_loader:
            images, labels = images.to(device), labels.to(device)

            optimizer.zero_grad()
            outputs = model(images)
            loss = criterion(outputs, labels)
            loss.backward()
            optimizer.step()

            total_loss += loss.item()
            correct += (outputs.argmax(1) == labels).sum().item()

        train_loss = total_loss / len(train_loader)
        train_acc = correct / len(train_loader.dataset)
        val_loss, val_acc = evaluate_model(model, val_loader, return_loss=True)

        train_losses.append(train_loss)
        val_losses.append(val_loss)

        print(f"Epoch {epoch+1}: Train Loss: {train_loss:.4f}, Train Acc: {train_acc:.4f}, Val Loss: {val_loss:.4f}, Val Acc: {val_acc:.4f}")

        # Early stopping logic
        global best_val_loss, patience_counter
        if val_loss < best_val_loss:
            best_val_loss = val_loss
            patience_counter = 0
            torch.save(model.state_dict(), best_model_path)  # Save best model
            print("✅ Best model saved!")
        else:
            patience_counter += 1
            print(f"⏳ Early stopping counter: {patience_counter}/{early_stopping_patience}")

        if patience_counter >= early_stopping_patience:
            print("⛔ Early stopping triggered! Restoring best model...")
            model.load_state_dict(torch.load(best_model_path))  # Restore best model
            break

    # Plot training & validation loss
    plot_loss(train_losses, val_losses)

# Evaluation function (returns validation loss if needed)
def evaluate_model(model, data_loader, return_loss=False):
    model.eval()
    correct = 0
    total_loss = 0

    with torch.no_grad():
        for images, labels in data_loader:
            images, labels = images.to(device), labels.to(device)
            outputs = model(images)
            loss = criterion(outputs, labels)
            total_loss += loss.item()
            correct += (outputs.argmax(1) == labels).sum().item()

    accuracy = correct / len(data_loader.dataset)
    if return_loss:
        return total_loss / len(data_loader), accuracy
    return accuracy

# Plot training and validation loss
def plot_loss(train_losses, val_losses):
    plt.figure(figsize=(8, 5))
    plt.plot(train_losses, label="Train Loss", marker="o")
    plt.plot(val_losses, label="Val Loss", marker="o")
    plt.xlabel("Epochs")
    plt.ylabel("Loss")
    plt.title("Training and Validation Loss")
    plt.legend()
    plt.grid()
    plt.show()

if __name__ == '__main__':
    import torch.multiprocessing as mp
    mp.set_start_method('spawn', force=True) 

    # Load datasets
    train_dataset = FootprintDataset('class/train_data.npz', transform=train_transform)
    val_dataset = FootprintDataset('class/val_data.npz', transform=test_transform)
    test_dataset = FootprintDataset('class/test_data.npz', transform=test_transform)

    # Create data loaders
    batch_size = 32
    train_loader = DataLoader(train_dataset, batch_size=batch_size, shuffle=True, num_workers=4)
    val_loader = DataLoader(val_dataset, batch_size=batch_size, shuffle=False, num_workers=4)
    test_loader = DataLoader(test_dataset, batch_size=batch_size, shuffle=False, num_workers=4)

    # Train model with early stopping
    train_model(model, train_loader, val_loader, epochs=20)

    # Load best model before final testing
    model.load_state_dict(torch.load(best_model_path))
    print("✅ Best model restored for testing.")

    # Evaluate on test set
    test_accuracy = evaluate_model(model, test_loader)
    print(f"🎯 Test Accuracy: {test_accuracy:.4f}")
