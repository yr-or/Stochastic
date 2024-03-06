
def prob_to_bipolar(x):
	return (2*x)-1

def prob_int_to_bipolar(x):
	return prob_to_bipolar(x/256)

def bipolar_to_prob(y):
	return (y+1)/2

def bipolar_to_prob_int(y):
	return int(bipolar_to_prob(y)*256)


# Test data
test_inputs = (
	[182, 59, 17, 134, 155, 116, 48, 147], 
	[66, 67, 112, 162, 140, 227, 138, 70], 
	[80, 97, 92, 161, 137, 78, 190, 29], 
	[47, 232, 11, 74, 102, 12, 28, 187], 
	[216, 89, 48, 1, 174, 107, 57, 237]
	)

test_weights = (
	[3, 149, 145, 141, 174, 165, 225, 106], 
	[232, 67, 72, 142, 230, 188, 167, 207], 
	[11, 250, 2, 139, 202, 134, 152, 59], 
	[255, 180, 62, 164, 59, 9, 76, 96], 
	[57, 212, 20, 146, 148, 251, 184, 175]
	)

bias = 138

# Set test data
test_no = 4
x = test_inputs[test_no]
w = test_weights[test_no]
print(x)
print(w)

# Get bipolar values
x_bi = [prob_int_to_bipolar(i) for i in x]
w_bi = [prob_int_to_bipolar(i) for i in w]
bias_bi = prob_int_to_bipolar(bias)

print("x_bi = ", x_bi)
print("w_bi = ", w_bi)
print("bias_bi = ", bias_bi)

# Multiply
mul = [x_bi[i]*w_bi[i] for i in range(len(x_bi))]
print("mul = ", mul)

# Sum pairs and /2
add_1 = [ (mul[i*2]+mul[(i*2)+1])/2 for i in range(4) ]
add_2 = [ (add_1[i*2]+add_1[(i*2)+1])/2 for i in range(2) ]
add_3 = (add_2[0] + add_2[1])/2
print("add1 = ", add_1)
print("add2 = ", add_2)
print("add3 = ", add_3)

# Add bias and /2
bias_out = (add_3 + bias_bi)/2
print("Bias out: ", bias_out)

# Apply activation function
result = 0;
if bias_out > 0:
	result = bias_out

# Result
print("Result = ", result)

# Display result in integer probability form
print("result prob int = ", bipolar_to_prob_int(result))