import random

print(f"reg [7:0] LFSR_seeds_L2 [0:7][0:16] =", "'{")
for j in range(8):
	x = [random.randrange(1,256) for i in range(8)]
	print("\t{", str(x)[1:-2], "},")

print("};")

	