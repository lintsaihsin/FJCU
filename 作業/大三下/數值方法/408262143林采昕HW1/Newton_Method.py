from math import *
import numpy as np
import matplotlib.pyplot as plt 
def f(x):
  return x**3 - x - 2
  # return x ** 3 + x ** 2 + x + 1
  # return exp(2 * x) - 3 * sin(x) - x - 2.5
  # return (exp(1.63*x*sin(x))) - 2.38*x*x -3.6*x +1.24
def fp(x):
  return 3*x**2 - 1
  # return 2 * exp(2 * x) - 3 * cos(x) - 1
  # return 3 * x ** 2 + 2 * x + x
  # return -4.76*x + 1.63 * (exp(1.63*x*sin(x))) * (x*cos(x)+sin(x)) -3.6

def main():
  epsilon = 1e-8
  
  x0 = 0.5
  x1 = x0 - f(x0) / fp(x0)
  mina = min(x0, x1)
  maxb = min(x0, x1)
  while abs(x1-x0) >= epsilon:
    x0 = x1
    x1 = x0 - f(x0) / fp(x0)
    x = []
    y = []
    print(x0, x1)
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
  plt.plot(x, y, color="black" , zorder=0) #畫線
  
  plt.hlines(0, mina, maxb, color="blue" , zorder=5) 
  print("sol is ", x1)
  print(mina, maxb)
  plt.scatter(x1, f(x1) , color="black", zorder=10)
  plt.grid()
  plt.title("Newton")
  plt.savefig("q2_NM.png")

if __name__ == '__main__':
  main() 