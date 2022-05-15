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

print(len(a))

for i in (10, 12, 15, 20, 25, 30, 35, 40, 45, 50, 55):
    b = []
    j = 0
    k = 0
    sum = 0
    while j < 123455:
        sum += a[j]
        j += 1
        k += 1
        if k == i:
            b.append((sum + i - 1) // i)
            sum = 0
            k = 0
    print(len(b))
    num, total = count(b)
    plt.bar(num, total, label = 'count')
    plt.savefig('count_Divide_to' + str(i) + '.png')
    plt.clf()