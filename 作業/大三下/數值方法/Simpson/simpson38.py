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

def simpson38(b):
  n = 10 ** 5
  sum = f(0) + f(b)
  d = b / n
  for k in range(1, n):
    if k % 3 == 0:
      sum += 2 * f(k * d)
    else :
      sum += 3 * f(k * d)
  return sum * d * 3 / 8 + 0.5

matrix38 = np.array([ [ 0. for _ in range(2) ] for _ in range(4895) ])


i = 0.0
num = 0
while(True):
  i = round(i, 3)
  ans38 = round(simpson38(i), 6)
  matrix38[num][0] = i
  matrix38[num][1] = ans38
  i += 0.001
  num += 1
  if ans38 >= 1:
    break

print(matrix38)
pd.DataFrame(matrix38).to_csv("simpson38.csv", index=False )
