import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

def main() :

    train_dataset = [
        [1, 0, 1],
        [1, 3, -1],
        [2, -6, 1],
        [-1, -3, 1],
        [-5, 5, -1],
        [5, 2, 1],
        [-2, 2, -1],
        [-7, 2, -1],
        [4, -4, 1],
        [-5, -1, -1]
    ]

    test_dataset = [
        [2, -4],
        [-5, 1],
        [-2, -2],
    ]

    train_dataset = np.array(train_dataset)
    test_dataset = np.array(test_dataset)
    train_feature = train_dataset[:,:2] 
    #-----取dataset的前兩位----
    # train_feature = [
    #      [ 1  0]
    #      [ 1  3]
    #      [ 2 -6]
    #      [-1 -3]
    #      [-5  5]
    #      [ 5  2]
    #      [-2  2]
    #      [-7  2]
    #      [ 4 -4]
    #      [-5 -1]
    # ]
    # -------------------------
    train_label = train_dataset[:,-1] 
    # ---取dataset的後一位---
    # [ 1 -1  1  1 -1  1 -1 -1  1 -1]
    # ----------------------
    
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

        tpred = [] #放test_dataset的答案
    for x in test_dataset:
        y = np.dot(w.T, x.T) + b; #算出每個點的答案
        if y < 0 :
            y = -1
        else :
            y = 1
        tpred.append(y)

 #-----------------畫圖---------------       
    plt.suptitle('Training and Testing Data : %.6f * X1 + %.6f * X2 + %.6f = 0' %(w[0], w[1], b)) #title
    plt.ylabel("x2") # y label
    plt.xlabel("x1") # x label
    _x = np.linspace(-10, 10) #放入100個範圍在 -10 ~ 10的x座標
    #------------
    #   [-10.          -9.59183673  -9.18367347  -8.7755102   -8.36734694
    # -7.95918367  -7.55102041  -7.14285714  -6.73469388  -6.32653061
    # -5.91836735  -5.51020408  -5.10204082  -4.69387755  -4.28571429
    # -3.87755102  -3.46938776  -3.06122449  -2.65306122  -2.24489796
    # -1.83673469  -1.42857143  -1.02040816  -0.6122449   -0.20408163
    #  0.20408163   0.6122449    1.02040816   1.42857143   1.83673469
    #  2.24489796   2.65306122   3.06122449   3.46938776   3.87755102
    #  4.28571429   4.69387755   5.10204082   5.51020408   5.91836735
    #  6.32653061   6.73469388   7.14285714   7.55102041   7.95918367
    #  8.36734694   8.7755102    9.18367347   9.59183673  10.        ]
    #-----------
    plt.xlim(-10,6) #x軸的範圍
    plt.ylim(-10,10) #y軸的範圍
    
    plt.plot(_x, ((w[0,0]*_x+b )/-w[1, 0]).T) #畫線
    for x, z in zip(train_feature, pred):
        if z == 1  :#點在線上
            p1 = plt.scatter(x[0], x[1] ,color='black', marker = 'o')
        else:#點在線下
            p2 = plt.scatter(x[0], x[1], color='red', marker = 'x')
    for x, z in zip(test_dataset, pred):
        if z == 1  :#點在線上
            p3 = plt.scatter(x[0], x[1], color='black', marker = '^')
        else:#點在線下
            p4 = plt.scatter(x[0], x[1], color='red', marker = '^')
    #圖例
    plt.legend([p1, p2, p3, p4], ['+1(Training)', '- 1(Training)', '+1(Testing)', '- 1(Testing)'], loc = 'lower right')
    plt.grid() #格線
    plt.show()

if __name__ == '__main__':
    main()
