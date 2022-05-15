import random

fo = open("testdata.in", "w")
output = ""
for i in range(1, 123456):
    x = random.randint(120, 180)
    output += str(x) + '\n'

fo.write(output)
fo.close()