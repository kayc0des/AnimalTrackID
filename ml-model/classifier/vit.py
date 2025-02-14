import numpy as np
import torch
import torch.nn as nn
import torch.optim as optim
from torch.utils.data import Dataset, DataLoader
import torchvision.transforms as transforms
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

# Define preprocessing transformations
train_transform = transforms.Compose([
    transforms.RandomHorizontalFlip(),
    transforms.RandomRotation(15),
    transforms.ColorJitter(brightness=0.2, contrast=0.2),
    transforms.Normalize(mean=[0.5], std=[0.5])  # Normalize (if grayscale)
])

test_transform = transforms.Compose([
    transforms.Normalize(mean=[0.5], std=[0.5])
])

# Load Vision Transformer (ViT) model
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
model = create_model("vit_base_patch16_224", pretrained=True, num_classes=18)
model = model.to(device)

# Define loss function and optimizer
criterion = nn.CrossEntropyLoss()
optimizer = optim.AdamW(model.parameters(), lr=3e-4, weight_decay=1e-4)

# Training function
def train_model(model, train_loader, val_loader, epochs=10):
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
        val_acc = evaluate_model(model, val_loader)

        print(f"Epoch {epoch+1}: Train Loss: {total_loss/len(train_loader):.4f}, Train Acc: {train_acc:.4f}, Val Acc: {val_acc:.4f}")

# Evaluation function
def evaluate_model(model, data_loader):
    model.eval()
    correct = 0

    with torch.no_grad():
        for images, labels in data_loader:
            images, labels = images.to(device), labels.to(device)
            outputs = model(images)
            correct += (outputs.argmax(1) == labels).sum().item()

    return correct / len(data_loader.dataset)

if __name__ == '__main__':
    import torch.multiprocessing as mp
    mp.set_start_method('spawn', force=True)  # Ensures proper multiprocessing on macOS

    # Load datasets
    train_dataset = FootprintDataset('npz/train_data.npz', transform=train_transform)
    val_dataset = FootprintDataset('npz/val_data.npz', transform=test_transform)
    test_dataset = FootprintDataset('npz/test_data.npz', transform=test_transform)

    # Create data loaders
    batch_size = 32
    train_loader = DataLoader(train_dataset, batch_size=batch_size, shuffle=True, num_workers=4)
    val_loader = DataLoader(val_dataset, batch_size=batch_size, shuffle=False, num_workers=4)
    test_loader = DataLoader(test_dataset, batch_size=batch_size, shuffle=False, num_workers=4)

    # Train and test the model
    train_model(model, train_loader, val_loader, epochs=10)
    test_accuracy = evaluate_model(model, test_loader)
    print(f"Test Accuracy: {test_accuracy:.4f}")
