# ---
# 結束 : |x1-x0| < epsilon
# ---
from math import *
import numpy as np
import matplotlib.pyplot as plt 
def f(x):
  return x**3 - x - 2
  # return x ** 3 + x ** 2 + x + 1
  # return (exp(1.63*x*sin(x))) - 2.38*x*x -3.6*x +1.24
  # return math.exp(2 * x) - 3 * math.sin(x) - x - 2.5
  # return x ** 2 - 4 * x + 2
  
def main():
  epsilon = 1e-6
  # x0 = np.random.rand()
  # x1 = np.random.rand()
  x0 = 1
  x1 = 0.5
  mina = min(x0, x1)
  maxb = min(x0, x1)
  while abs(x1 - x0) >= epsilon:
    print("x0 ", x0)
    print("x1 ", x1)
    print("=" * 30)
    x2 = (x0 * f(x1) - x1 * f(x0)) / (f(x1) - f(x0))
    x0 = x1
    x1 = x2
    x = []
    y = []
    x.append(x0)
    x.append(x1)
    y.append(f(x0))
    y.append(f(x1))
    mina = min(mina, x0)
    mina = min(mina, x1)
    maxb = max(maxb, x0)
    maxb = max(maxb, x1)
    plt.plot(x, y , zorder=1)

    
  x = []
  y = []
  seq = np.arange(mina, maxb + 0.01, 0.01)
  for i in range(len(seq)) :
    x.append(seq[i])
    y.append(f(seq[i]))
  plt.xlim(mina, maxb+0.01) #x軸的範圍
  plt.ylim(min(y), max(y)) #y軸的範圍
  plt.plot(x, y, color="black" , zorder=3) #畫線
  plt.hlines(0, mina, maxb, color="blue" , zorder=5) 
  print("sol is ", x1)
  plt.scatter(x1, f(x1) , color="black", zorder=10)
  plt.grid()
  
  plt.title("Secant")
  plt.savefig("q2_SM.png")

if __name__ == '__main__':
  main()