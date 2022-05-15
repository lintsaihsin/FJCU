import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import math
from tqdm import tqdm
#-------------------------
# evenly sampled time at 200ms intervals
# t = np.arange(0., 5., 0.2)

# # red dashes, blue squares and green triangles
# plt.plot(t, t, 'r--', t, t**2, 'bs', t, t**3, 'g^')
# plt.show()
#------------------
def one_hot(y):
    if y == 0 :
        return np.array([[1, 0, 0, 0]]);
    elif y == 1 :
        return np.array([[0, 1, 0, 0]]);
    elif y == 2 :
        return np.array([[0, 0, 1, 0]]);
    elif y == 3 :
        return np.array([[0, 0, 0, 1]]);
def main() :

    #input training、test的資料
    # train_dataset = pd.read_csv('lab3_train_test.csv').values

    train_dataset = pd.read_csv('lab3_train.csv').values
    test_dataset = pd.read_csv('lab3_test.csv').values
  
    train_dataset = np.array(train_dataset)
    test_dataset = np.array(test_dataset)
    train_feature = train_dataset[:,1:]
    #從第二位取dataset----
    train_label = train_dataset[:,0]
    #取dataset的第一位----
    train_feature = train_feature/255
    test_dataset = test_dataset/255

    tenfold_len = int(len(train_feature)*0.9)
    # 將train_feature後1/10拆出來算準確率
    val_feature = train_feature[tenfold_len:] 
    val_label = train_label[tenfold_len:]
    train_feature = train_feature[:tenfold_len]
    train_label = train_label[:tenfold_len]

    # 轉換y (0 -> 0, 3 -> 1, 8 -> 2, 9 -> 3)
    for idx in range(len(train_label)): 
        if train_label[idx] == 3:
            train_label[idx] = 1
        elif train_label[idx] == 8:
            train_label[idx] = 2
        elif train_label[idx] == 9:
            train_label[idx] = 3
    w1 = np.random.uniform(size = (200, 784), low = -0.5, high = 0.5)
    b1 = np.random.uniform(size = (200, 1), low = -0.5, high = 0.5)
    w2 = np.random.uniform(size = (4, 200), low = -0.5, high = 0.5)
    b2 = np.random.uniform(size = (4, 1), low = -0.5, high = 0.5)
    lr = 0.1
    # 隨機產生W1 ... Wm，b，lr------
    for epoch in tqdm(range(15)): # 設epoch為100，若跑100次還是沒找到可以分開所有點的線，則強制結束
        print("epoch : ", epoch)
        lprd = []
        pred = [] #放算出來的y_hat
        for x, y in zip(train_feature, train_label):
            x = np.expand_dims(x, axis=0)
            # print("x : ", x)
            n1 = np.dot(w1, x.T) + b1
            # print("n1 : ", n1)
            a1 = 1/(1 + np.exp(-1*(n1))); #算出sigmoid(n)
            # print("a1 : ", a1)
            n2 = np.dot(w2, n1) + b2
            # print("n2 : ", n2)
            a2 = 1/(1 + np.exp(-1*(n2))); #算出sigmoid(n)
            # print("a2 : ", a2)
            # print("y : ", y)
            y_hot = one_hot(y)
            delta_2 = a2 - y_hot.T
            # print("y_hot 2 : ", y_hot)
            # print("delta_2 : ", delta_2)
            delta_1 = np.dot(w2.T, delta_2) * a1 * (1-a1)
            # print("a2 : ", a2)
            # 將轉換所有one_hot
            max = 0
            max_index = 0
            for i in range(0, 4) :
                if max < a2[i] :
                    max_index = i
                    max = a2[i]
            lprd.append(one_hot(max_index).T)
            # 轉換y (0 -> 0, 1 -> 3, 2 -> 8, 3 -> 9)
            if max_index == 1:
                max_index = 3
            elif max_index == 2:
                max_index = 8
            elif max_index == 3:
                max_index = 9
                    
            pred.append(max_index)
            
            w1 = w1 - lr * np.dot(delta_1,x)
            b1 = b1 - delta_1 *lr
            w2 = w2 - lr * np.dot(delta_2,a1.T)
            b2 = b2 - delta_2 *lr

        ppred = np.array(lprd)
        print("ppred : ", ppred)
        # exit()
        print("loss : ")
        epsilon = 1e-9
        loss = -1*(np.mean(train_label*np.log(ppred + epsilon) + (1-train_label)*np.log(1-ppred+ epsilon)))
        print(loss)
        #若每個點都符合，則直接break出迴圈
        if (pred == train_label).all():
            break

    val_pred = []#放val__feature的答案
    for x in val_feature:
        x = np.expand_dims(x, axis=0)
        n1 = np.dot(w1, x.T) + b1
        a1 = 1/(1 + np.exp(-1*(n1))); #算出sigma(n)
        n2 = np.dot(w2, n1) + b2
        a2 = 1/(1 + np.exp(-1*(n2)));
        # 將轉換所有one_hot
        max = 0
        max_index = 0
        for i in range(0, 4) :
            if max < a2[i] :
                max_index = i
                max = a2[i]
        # 轉換y (0 -> 0, 1 -> 3, 2 -> 8, 3 -> 9)
        if max_index == 1:
            max_index = 3
        elif max_index == 2:
            max_index = 8
        elif max_index == 3:
            max_index = 9
                
        val_pred.append(max_index)

    print("acc") 
    # 正確答案/全部答案
    acc = sum(val_pred == val_label)/len(val_pred)
    print(acc)

    tpred = []#放test_dataset的答案
    for x in test_dataset:
        x = np.expand_dims(x, axis=0)
        n1 = np.dot(w1, x.T) + b1
        a1 = 1/(1 + np.exp(-1*(n1))); #算出sigma(n)
        n2 = np.dot(w2, n1) + b2
        a2 = 1/(1 + np.exp(-1*(n2)));
        # 將轉換所有one_hot
        max = 0
        max_index = 0
        for i in range(0, 4) :
            if max < a2[i] :
                max_index = i
                max = a2[i]
        # 轉換y (0 -> 0, 1 -> 3, 2 -> 8, 3 -> 9)
        if max_index == 1:
            max_index = 3
        elif max_index == 2:
            max_index = 8
        elif max_index == 3:
            max_index = 9
                
        tpred.append(max_index)

    print("epoch")
    print(epoch)
    print("learning rate")
    print(lr)
    print("layer")
    print("[784, 200, 4]")
    pd.DataFrame(tpred, columns = ['ans']).to_csv('test_ans.csv', index = False)




if __name__ == '__main__':
    main()
