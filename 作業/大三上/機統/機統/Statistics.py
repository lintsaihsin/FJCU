import matplotlib.pyplot as plt

def count(a):
    num = []
    total = []
    for i in range(120, 180 + 1):
        num.append(str(i))
        total.append(a.count(i))
    return num, total

fi = open("testdata.in", "r")
lines = fi.readlines()
a = []

for line in lines:
    x = line.replace('\n', '')
    x = int(x)
    a.append(x)

num, total = count(a)
plt.suptitle('total') #title
plt.ylabel("amount") # y label
plt.xlabel("height") # x label
plt.bar(num, total, label = 'count')
plt.savefig('total_count.png')
plt.show()