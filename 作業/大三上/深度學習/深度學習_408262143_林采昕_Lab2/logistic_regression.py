import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import math
#-------------------------
# evenly sampled time at 200ms intervals
# t = np.arange(0., 5., 0.2)

# # red dashes, blue squares and green triangles
# plt.plot(t, t, 'r--', t, t**2, 'bs', t, t**3, 'g^')
# plt.show()
#------------------

def main() :

    #input training、test的資料
    train_dataset = pd.read_csv('train.csv').values
    test_dataset = pd.read_csv('test.csv').values
  
    train_dataset = np.array(train_dataset)
    test_dataset = np.array(test_dataset)
    train_feature = train_dataset[:,1:]
    #從第二位取dataset----
    train_label = train_dataset[:,0]
    #取dataset的第一位----
    
    tenfold_len = int(len(train_feature)*0.9)
    # 將train_feature後1/10拆出來算準確率
    val_feature = train_feature[tenfold_len:] 
    val_label = train_label[tenfold_len:]
    train_feature = train_feature[:tenfold_len]
    train_label = train_label[:tenfold_len]

    # 轉換y (2 -> 1, 5 -> 0)
    for idx in range(len(train_label)): 
        if train_label[idx] == 2:
            train_label[idx] = 1
        else :
            train_label[idx] = 0


    w = np.random.rand(784, 1)
    b = np.random.rand(1,1)
    lr = np.random.rand(1,1)
    # 隨機產生W1 ... Wm，b，lr------
    for epoch in range(100): # 設epoch為100，若跑100次還是沒找到可以分開所有點的線，則強制結束
        pred = [] #放算出來的y_hat
        for x, y in zip(train_feature, train_label):
            y_hat = np.dot(w.T, x) + b
            y_hat = 1/(1 + np.exp(-1*(y_hat))); #算出sigma(n)
            # 將轉換所有y_hat
            if y_hat >= 0.5 :
                y_hat = 1
            else :
                y_hat = 0

            pred.append(y_hat)
            
            x = np.expand_dims(x, axis=0)
            w = w - lr * (y_hat-y) * x.T 
            b = b - (y_hat-y) *lr

        ppred = np.array(pred)
        print("loss : ")
        epsilon = 1e-9
        loss = -1*(np.mean(train_label*np.log(ppred + epsilon) + (1-train_label)*np.log(1-ppred+ epsilon)))
        print(loss)
        # quit()
        #若每個點都符合，則直接break出迴圈
        if (pred == train_label).all():
            break

    val_pred = []#放val_feature的答案
    for x in val_feature:
        y = np.dot(w.T, x) + b
        y = 1/(1 + np.exp(-1*(y))); 
        if y >= 0.5 :
                y = 2
        else :
            y = 5 
        val_pred.append(y)

    print("acc") 
    # 正確答案/全部答案
    acc = sum(val_pred == val_label)/len(val_pred)
    print(acc)

    tpred = []#放test_dataset的答案
    for x in test_dataset:
        y = np.dot(w.T, x) + b
        y = 1/(1 + np.exp(-1*(y))); 
        if y >= 0.5 :
                y = 2
        else :
            y = 5
        tpred.append(y)

    print("weight")
    print(w)
    print("learning rate")
    print(lr)
    print("epoch")
    print(epoch)
    pd.DataFrame(tpred, columns = ['ans']).to_csv('test_ans.csv', index = False)




if __name__ == '__main__':
    main()
