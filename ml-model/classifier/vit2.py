import numpy as np
import torch
import torch.nn as nn
import torch.optim as optim
from torch.utils.data import Dataset, DataLoader
import torchvision.transforms as transforms
import matplotlib.pyplot as plt
from timm import create_model
from sklearn.preprocessing import LabelEncoder

# Custom Dataset to load npz files
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

# Define preprocessing transformations (only normalization)
transform = transforms.Compose([
    transforms.Normalize(mean=[0.5], std=[0.5])
])

# Load Vision Transformer (ViT) model
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
model = create_model("vit_base_patch16_224", pretrained=True, num_classes=6)

# Add dropout to the classifier for regularization
model.head = nn.Sequential(
    nn.Dropout(p=0.3),
    nn.Linear(model.head.in_features, 6)
)

model = model.to(device)

# Define loss function and optimizer
criterion = nn.CrossEntropyLoss()
optimizer = optim.AdamW(model.parameters(), lr=1e-4, weight_decay=1e-3)

# Training function with Early Stopping
def train_model(model, train_loader, val_loader, epochs=20, patience=2):
    best_val_loss = float('inf')
    best_model_weights = None
    patience_counter = 0
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

        train_acc = correct / len(train_loader.dataset)
        val_loss, val_acc = evaluate_model(model, val_loader, return_loss=True)

        train_losses.append(total_loss / len(train_loader))
        val_losses.append(val_loss)

        print(f"Epoch {epoch+1}: Train Loss: {train_losses[-1]:.4f}, Train Acc: {train_acc:.4f}, Val Loss: {val_loss:.4f}, Val Acc: {val_acc:.4f}")

        # Early Stopping Check
        if val_loss < best_val_loss:
            best_val_loss = val_loss
            best_model_weights = model.state_dict()
            patience_counter = 0
        else:
            patience_counter += 1
            if patience_counter >= patience:
                print("Early stopping triggered. Restoring best model weights.")
                model.load_state_dict(best_model_weights)
                break

    # Save the model
    torch.save(model.state_dict(), 'model/best_model.pth')
    print("Model saved successfully.")

    # Plot loss graph
    plt.plot(train_losses, label='Train Loss', marker='o')
    plt.plot(val_losses, label='Val Loss', marker='o')
    plt.xlabel('Epochs')
    plt.ylabel('Loss')
    plt.title('Training and Validation Loss')
    plt.legend()
    plt.grid()
    plt.show()

# Evaluation function with loss computation
def evaluate_model(model, data_loader, return_loss=False):
    model.eval()
    correct, total_loss = 0, 0
    
    with torch.no_grad():
        for images, labels in data_loader:
            images, labels = images.to(device), labels.to(device)
            outputs = model(images)
            loss = criterion(outputs, labels)
            total_loss += loss.item()
            correct += (outputs.argmax(1) == labels).sum().item()
    
    accuracy = correct / len(data_loader.dataset)
    avg_loss = total_loss / len(data_loader) if return_loss else None
    return (avg_loss, accuracy) if return_loss else accuracy

if __name__ == '__main__':
    import torch.multiprocessing as mp
    mp.set_start_method('spawn', force=True) 

    # Load datasets
    train_dataset = FootprintDataset('new/train_data.npz', transform=transform)
    val_dataset = FootprintDataset('new/val_data.npz', transform=transform)
    test_dataset = FootprintDataset('new/test_data.npz', transform=transform)

    # Create data loaders
    batch_size = 32
    train_loader = DataLoader(train_dataset, batch_size=batch_size, shuffle=True, num_workers=4)
    val_loader = DataLoader(val_dataset, batch_size=batch_size, shuffle=False, num_workers=4)
    test_loader = DataLoader(test_dataset, batch_size=batch_size, shuffle=False, num_workers=4)

    # Train and test the model
    train_model(model, train_loader, val_loader, epochs=20, patience=2)
    test_accuracy = evaluate_model(model, test_loader)
    print(f"Test Accuracy: {test_accuracy:.4f}")
