'''Information
This template is for Deep-learning class 2021.
Please read the assignment requirements in detail and fill in the blanks below.
Any part that fails to meet the requirements will deduct the points.
Please answer carefully.
'''

# Please import the required packages
import torch
import torch.nn as nn
import torch.nn.functional as F
import torchvision
import numpy as np
from torch.utils.data import DataLoader

from tqdm import tqdm
import torchvision.transforms as transforms
# Define NeuralNetwork
class ConvolutionalNeuralNetwork(nn.Module):
    def __init__(self):
        super(ConvolutionalNeuralNetwork, self).__init__()
        # image shape is 3 * 32 * 32, which
        # 3 is for RGB three-color channel, 32 * 32 is for image size

        # ------- convalution layer -------
        # please add at least one more layer of conv
        # ::: your code :::
        self.conv1 = nn.Conv2d(in_channels= 3, out_channels= 6, kernel_size= 5)
        self.conv2 = nn.Conv2d(in_channels= 6, out_channels= 16, kernel_size= 5)
        #設定convalution layer的大小 
        # ::: end of code :::

        # ------- pooling layer and activation function -------
        # ::: your code :::
        self.pool = nn.MaxPool2d(kernel_size= 2, stride= 2)
        #設定pooling layer的大小
        self.relu = nn.ReLU()
        # ::: end of code :::

        # ------- fully connected layers -------
        # ::: your code :::
        self.fc1 = nn.Linear( 16 * 5 * 5, 120)
        self.fc2 = nn.Linear( 120, 84)
        self.fc3 = nn.Linear( 84, 10)
        # 10 => 10種類型
        # The number of neurons in the last fully connected layer 
        # should be the same as number of classes

        # ::: end of code :::
        

    def forward(self, x):
        # first conv
        x = self.pool(self.relu(self.conv1(x))) # please count out the size for each layer
        # example: x = self.pool(self.relu(self.conv1(x))) # output size = 10x25x25
        # second conv
        # ::: your code :::
        x = self.pool(self.relu(self.conv2(x)))
        # ::: end of code :::

        # flatten all dimensions except batch
        x = torch.flatten(x, 1)
        # fully connection layers
        # ::: your code :::
        x = F.relu(self.fc1(x))
        x = F.relu(self.fc2(x))
        x = self.fc3(x)
        # ::: end of code :::

        return x


def train():
    # Device configuration
    # ::: your code :::
    device = torch.device('cuda:0' if torch.cuda.is_available() else 'cpu')
    # ::: end of code :::

    # set up basic parameters
    # ::: your code :::
    num_epochs = 50
    batch_size = 50
    learning_rate = 0.001
    # ::: end of code :::

    # step 0: import the data and set it as Pytorch dataset
    # Dataset: CIFAR10 dataset
    transform = transforms.Compose([transforms.ToTensor(), 
                                    transforms.Normalize((0.5, 0.5, 0.5), (0.5, 0.5, 0.5))])
    CIFAR10_train_data = torchvision.datasets.CIFAR10('./data', train=True, download=True, transform=transform)
    CIFAR10_test_data = torchvision.datasets.CIFAR10('./data', train=False, download=True, transform=transform)

    train_loader = DataLoader(dataset=CIFAR10_train_data, batch_size=batch_size)
    test_loader = DataLoader(dataset=CIFAR10_test_data, batch_size=batch_size)

    # step 1: set up models, criterion and optimizer
    model = ConvolutionalNeuralNetwork().to(device).train()
    criterion = nn.CrossEntropyLoss()
    optimizer = torch.optim.Adam(model.parameters(), lr=learning_rate)

    # step 2: start training
    n_total_steps = len(train_loader)
    for epoch in tqdm(range(num_epochs)):
        for i, (images, labels) in enumerate(train_loader):
            images, labels = images.to(device), labels.to(device)
            # ::: your code :::
            # init optimizer
            optimizer.zero_grad()

            # forward -> backward -> update
            outputs = model(images)
            loss = criterion(outputs, labels)
            loss.backward()
            optimizer.step()

            # ::: end of code :::
        print(f'epoch {epoch+1}/{num_epochs}, loss = {loss.item():.4f}')

        # step 3: Validation loop
        # ::: your code :::
        for i, (images, labels) in enumerate(train_loader):
            images, labels = images.to(device), labels.to(device)
             
            outputs = model(images)
            loss = criterion(outputs, labels)
        # ::: end of code :::
    print('Finished Training')

    # set model to Evaluation Mode
    model = model.eval()
    

    # step 4: Testing loop
    # no grad here
    with torch.no_grad():
        n_correct = 0
        n_samples = 0
        n_class_correct = [0 for i in range(10)]
        n_class_samples = [0 for i in range(10)]
        # run through testing data
        
        # ::: your code :::
        for i, (images, labels) in enumerate(test_loader):
            images, labels = images.to(device), labels.to(device)

            # ::: end of code :::
            outputs = model(images)
            # max returns (value, index)
            _, predicted = torch.max(outputs, 1)
            n_samples += labels.size(0)
            n_correct += (predicted == labels).sum().item()

            for i in range(batch_size):
                label = labels[i]
                pred = predicted[i]
                if (label == pred):
                    n_class_correct[label] += 1
                n_class_samples[label] += 1

        acc = 100.0 * n_correct / n_samples
        print(f'Accuracy of the network: {acc} %')

        for i in range(10):
            acc = 100.0 * n_class_correct[i] / n_class_samples[i]
            print(f'Accuracy of {i}: {acc} %')

    # save your model
    # ::: your code :::
    torch.save(model.state_dict(), 'cnn1.pt')
    # ::: end of code :::


if __name__ == '__main__':
    train()
