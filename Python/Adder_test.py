
def prob_to_bipolar(x):
	return (2*x)-1

def prob_int_to_bipolar(x):
	return prob_to_bipolar(x/256)

def bipolar_to_prob(y):
	return (y+1)/2

def bipolar_to_prob_int(y):
	return int(bipolar_to_prob(y)*256)

def unipolar_to_int(x):
	return int(x*256)

def int_to_unipolar(x):
	return x/256

num1_test = [226, 194, 223, 255, 58, 59, 136, 102, 86, 225, 26, 168, 197, 216, 124, 132, 33, 90, 240, 232, 90, 177, 37, 202, 19, 168, 109, 216, 127, 145, 95, 21, 190, 4, 164, 94, 65, 26, 178, 31, 61, 185, 76, 207, 157, 225, 73, 221, 97, 161, 96, 74, 221, 126, 241, 16, 181, 61, 122, 33, 24, 173, 108, 171, 73, 83, 85, 161, 139, 212, 182, 128, 42, 184, 154, 205, 96, 126, 67, 162, 155, 103, 56, 112, 218, 170, 168, 102, 20, 14, 165, 234, 158, 75, 250, 198, 168, 205, 192, 70]
num2_test = [64, 16, 30, 172, 24, 94, 19, 206, 252, 7, 134, 197, 127, 233, 73, 190, 59, 251, 85, 118, 70, 181, 234, 70, 177, 70, 1, 126, 187, 220, 48, 117, 193, 248, 233, 104, 204, 246, 247, 152, 11, 88, 30, 10, 190, 231, 14, 103, 210, 226, 245, 167, 217, 124, 255, 2, 77, 254, 153, 38, 208, 129, 231, 52, 22, 125, 179, 167, 62, 71, 234, 77, 219, 150, 184, 18, 93, 92, 161, 177, 206, 25, 165, 212, 145, 145, 149, 185, 152, 157, 0, 195, 250, 245, 14, 167, 210, 81, 87, 105]

with open("Adder_test_python.txt", "w+") as f:
	for i in range(len(num1_test)):
		num1_bi = prob_int_to_bipolar(num1_test[i])
		num2_bi = prob_int_to_bipolar(num2_test[i])
		res = (num1_bi + num2_bi)/2
		#print(f"Test {i+1}")
		#print(f"Result_bi = {res}")
		#print(f"Result_int = {bipolar_to_prob_int(res)}")
		f.write(f"Test: {i+1}, Result: {bipolar_to_prob_int(res)}\n")