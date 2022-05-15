import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
#-------------------------
# evenly sampled time at 200ms intervals
# t = np.arange(0., 5., 0.2)

# # red dashes, blue squares and green triangles
# plt.plot(t, t, 'r--', t, t**2, 'bs', t, t**3, 'g^')
# plt.show()
#------------------

def main() :

    #input training、test的資料
    train_dataset = pd.read_csv('Iris_training.txt').values
    test_dataset = pd.read_csv('Iris_test.txt').values
    
    train_dataset = np.array(train_dataset)
    test_dataset = np.array(test_dataset)
    train_feature = train_dataset[:,:2]
    #取dataset的前兩位----
    train_label = train_dataset[:,-1]
    #取dataset的後一位----
    test_feature = test_dataset[:,:2]
    #取test的前兩位(不取最後面的答案)----
    w = np.random.rand(2, 1)
    b = np.random.rand(1,1)
    lr = np.random.rand(1,1)
    # 隨機產生w1，w2，b，lr------

    for epoch in range(100): # 設epoch為100，若跑100次還是沒找到可以分開所有點的線，則強制結束
        pred = [] #放算出來的y_hat
        for x, y in zip(train_feature, train_label):
            y_hat = np.dot(w.T, x.T) + b; #算出w1*x1 + w2*x2 + b
            # 將所有y_hat換成sign函數
            if y_hat < 0 :
                y_hat = -1
            else :
                y_hat = 1

            pred.append(y_hat)
            if y_hat != y: #若算出的預設答案不符合真實答案，則更新w、b
                x = np.expand_dims(x, axis=0)
                w = w + x.T* y *lr
                b = b + y *lr
        #若每個點都符合，則直接break出迴圈
        if (pred == train_label).all():
            break

        tpred = []#放test_dataset的答案
    for x in test_feature:
        y = np.dot(w.T, x.T) + b;
        if y < 0 :
            y = -1
        else :
            y = 1
        tpred.append(y)

 #-----------------畫圖---------------  
    plt.suptitle('Iris')
    plt.ylabel("sepal width") # y label
    plt.xlabel("sepal length") # x label
    _x = np.linspace(min(train_feature[:,0]), max(train_feature[:,0]))
    plt.xlim(min(train_feature[:,0]), max(train_feature[:,0])+0.5) #x軸的範圍
    plt.ylim(min(train_feature[:,1]), max(train_feature[:,1])+0.5) #y軸的範圍
    
    plt.plot(_x, ((w[0,0]*_x+b )/-w[1, 0]).T) #畫線
    for x, z in zip(train_feature, pred):
        if z == 1  : #點在線上
            p1 = plt.scatter(x[0], x[1] ,color='blue', marker = 'o')
        else: #點在線下
            p2 = plt.scatter(x[0], x[1], color='red', marker = 'x')
    for x in test_feature:
            p3 = plt.scatter(x[0], x[1], color='green', marker = '^')
    plt.legend([p1, p2, p3], ['Setosa', 'Non_Setosa', 'Test'], loc = 'upper right')
    # plt.legend(loc = 'lower right')
    plt.grid() #格線
    plt.savefig('figure_1.png')
    plt.clf()
    plt.suptitle('Iris')
    plt.ylabel("sepal width") # y label
    plt.xlabel("sepal length") # x label
    _x = np.linspace(min(train_feature[:,0]), max(train_feature[:,0]))
    plt.xlim(min(train_feature[:,0]), max(train_feature[:,0])+0.5) # x label
    plt.ylim(min(train_feature[:,1]), max(train_feature[:,1])+0.5) # y label
    
    plt.plot(_x, ((w[0,0]*_x+b )/-w[1, 0]).T) #畫線
    for x, z in zip(test_feature, pred):
        if z == 1  : #點在線上
            p1 = plt.scatter(x[0], x[1] ,color='blue', marker = 'o')
        else: #點在線下
            p2 = plt.scatter(x[0], x[1], color='red', marker = 'x')
    #圖例
    plt.legend([p1, p2], ['Setosa', 'Non_Setosa'], loc = 'upper right')
    plt.grid() #格線
    plt.savefig('figure_2.png')

if __name__ == '__main__':
    main()
