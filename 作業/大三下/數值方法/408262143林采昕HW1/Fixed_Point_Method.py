import numpy as np
import math
import matplotlib.pyplot as plt 

def g(x):
  return (5 * x + 14) ** (-2)

def main():
  epsilon = 1e-6
  x0 = 1
  x1 = g(x0)
  mina = min(x0, x1)
  maxb = min(x0, x1)
  while abs(x1 - x0) >= epsilon:
    print("x0 ", x0)
    print("x1 ", x1)
    x0 = x1
    x1 = g(x0)
    plt.hlines(x0, 0, g(x0), color="green" , zorder=1) 
    plt.hlines(x1, 0, g(x1), color="red", zorder=1) 
    plt.vlines(g(x0),0,x0,color="green", zorder=1)
    plt.vlines(g(x1),0,x1,color="red", zorder=1)
    
  x = []
  y = []
  seq = np.arange(mina, maxb + 0.01, 0.01)
  for i in range(len(seq)) :
    x.append(seq[i])
    y.append(g(seq[i]))
  plt.xlim(mina, maxb+0.01) #x軸的範圍
  plt.ylim(min(y), max(y)) #y軸的範圍
  plt.plot(x, y, color="black" , zorder=3) #畫線
  plt.hlines(0, mina, maxb, color="blue" , zorder=5) 
  print("sol is ", x1)
  plt.scatter(x1, g(x1) , color="black", zorder=10)
  plt.grid()
  plt.savefig("q1_FIXM.png")

if __name__ == '__main__':
  main()