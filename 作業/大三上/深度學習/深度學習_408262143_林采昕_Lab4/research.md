資工三乙 408262143 林采昕
a.如何進行正確的資料讀取才能進行有效的訓練，Pytorch 的相關套件該如何正確的使用和撰寫？
DataLoader(dataset=CIFAR10_train_data, batch_size=50)

b. 各 Pytorch function 有哪些參數可以做調整來取得更好的準確率？
epoch 、batch_size、learning_rate

c. 如何選擇正確的硬體進行數據訓練？
device = torch.device('cuda:0' if torch.cuda.is_available() else 'cpu')
torch.cuda.is_available()判斷cuda是否可使用。若可以，再會在GPU上進行編譯，反之，則在CPU上進行編譯。