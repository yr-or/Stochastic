import random

print(f"reg [7:0] LFSR_seeds_L2 [0:NUM_NEUR-1][0:NUM_INP-1] =", "'{")
for j in range(8):
	x = [random.randrange(1,256) for i in range(8)]
	print("\t{", str(x)[1:-1], "},")

print("};")

	