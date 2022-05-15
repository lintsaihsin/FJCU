# ---
# 找斜率
# 結束 : |m - mold| < epsilon 
# ---
from math import *
import numpy as np
import matplotlib.pyplot as plt 

def f(x):
  return x**3 - x - 2
  # return (exp(1.63*x*sin(x))) - 2.38*x*x -3.6*x +1.24
  # return math.exp(2 * x) - 3 * math.sin(x) - x - 2.5
  # return x ** 3 - 6 * x ** 2 + 11 * x -6

def main():
  a = 0
  b = 0
  epsilon = 1e-8
  #當f(a) f(b)同號時 擴大a b範圍 直到a b異號
  mina = a
  maxb = b 
  while (f(a) * f(b) >= 0):
    if (f(a) > 0 and a > 0):
      a = a * (-1.01)
    elif (f(a) > 0 and a == 0):
      a = -1
    elif (f(a) > 0) :
      a *= 1.01
    if (f(b) < 0 and b < 0):
      b = b * (-1.01)
    elif (f(b) < 0 and b == 0):
      b = 1
    elif (f(b) < 0):
      b *= 1.01
    # print("in")
    # print("a ", a, f(a))
    # print("b ",b, f(b))
    # print(f(a) * f(b))
    # print("=" *10)
    mina = a
    maxb = b
  mold = 0
  m = (a * f(b) - b * f(a))/ (f(b) - f(a))
  while abs(m - mold) >= epsilon:
    x = []
    y = []
    x.append(a)
    x.append(b)
    y.append(f(a))
    y.append(f(b))
    plt.plot(x, y , zorder=1)
    print("a ", a)
    print("b ", b)
    print("m ", m)
    print("x ", x)
    print("y ", y)
    print("=" * 10)
    # 縮小範圍
    if f(a) * f(m) < 0:
      b = m
    else : 
      a = m
    # print(m - mold)
    # print("")
    mold = m
    m = (a * f(b) - b * f(a))/ (f(b) - f(a))
  x = []
  y = []
  seq = np.arange(mina, maxb + 0.01, 0.01)
  for i in range(len(seq)) :
    x.append(seq[i])
    y.append(f(seq[i]))
  # print(y)
  plt.xlim(mina, maxb+0.01) #x軸的範圍
  plt.ylim(min(y), max(y)) #y軸的範圍
  plt.plot(x, y , zorder=1) #畫線
  plt.hlines(0, mina, maxb, color="blue" , zorder=5) 
    # print(i, f(i))
    
  print("sol is ", m)
  plt.scatter(m, f(m) , color="black", zorder=10)
  plt.grid()
  
  plt.title("False_Position")
  plt.savefig("q2_FPM.png")

if __name__ == '__main__':
  main()