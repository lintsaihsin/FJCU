import matplotlib.pyplot as plt
import argparse
import numpy as np
import collections.abc
from pptx import Presentation, util
from pptx.util import Pt
import os
import pandas as pd
import math

def f(x):
  return math.exp(-(x**2)/ 2) / ((2 * math.pi) ** 0.5)

def simpson13(b):
  n = 10 ** 5
  sum = f(0) + f(b)
  d = b / n
  for k in range(1, n):
    if k % 2 == 0:
      sum += 4 * f(k * d)
    else :
      sum += 2 * f(k * d)
  return sum * d / 3 + 0.5
matrix13 = np.array([ [ 0. for _ in range(2) ] for _ in range(5635) ])

i = 0
num = 0
while(True):
  i = round(i, 3)
  ans13 = round(simpson13(i), 6)
  matrix13[num][0] = i
  matrix13[num][1] = ans13
  print(num, " ", i, " ", ans13)
  if ans13 >= 1 or matrix13[num-1][1] > matrix13[num][1]:
    break
  i += 0.001
  num += 1
print(matrix13)
pd.DataFrame(matrix13).to_csv("simpson13.csv", index=False )