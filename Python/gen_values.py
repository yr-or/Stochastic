import random

for j in range(1):
	x = [random.randrange(0,256) for i in range(100)]
	#print("\t{", str(x)[1:-1], "},")

for i in range(18):
	print( f"{[random.randrange(0,120) for j in range(8)]}," )