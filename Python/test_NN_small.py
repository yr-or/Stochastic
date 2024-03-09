
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

def Neuron(inputs, weights, bias):
	"""
	Inputs: float values representing stoch probs.
	Outputs: float values repr. stoch. prob.
	"""
	# Multiply
	mul = [inputs[i]*weights[i] for i in range(len(inputs))]
	print("mul = ", mul)

	# Sum pairs and /2
	add_1 = [ (mul[i*2]+mul[(i*2)+1])/2 for i in range(4) ]
	add_2 = [ (add_1[i*2]+add_1[(i*2)+1])/2 for i in range(2) ]
	add_3 = (add_2[0] + add_2[1])/2
	print("add1 = ", add_1)
	print("add2 = ", add_2)
	print("add3 = ", add_3)

	# Add bias and /2
	bias_out = (add_3 + bias)/2
	print("Bias out: ", bias_out)

	# Apply activation function
	result = 0;
	if bias_out > 0:
		result = bias_out
	return result

# Test data
test_inputs = (
	[182, 59, 17, 134, 155, 116, 48, 147], 
	[66, 67, 112, 162, 140, 227, 138, 70], 
	[80, 97, 92, 161, 137, 78, 190, 29], 
	[47, 232, 11, 74, 102, 12, 28, 187], 
	[216, 89, 48, 1, 174, 107, 57, 237]
	)

# Layer weights
weights_L2 = (
	[110, 71, 221, 252, 136, 133, 118, 9], 
	[13, 168, 208, 110, 139, 233, 117, 1], 
	[215, 5, 108, 197, 251, 115, 133, 6], 
	[27, 98, 173, 160, 102, 224, 254, 20], 
	[181, 111, 117, 254, 37, 193, 182, 24], 
	[69, 8, 252, 69, 47, 7, 238, 25], 
	[ 220, 68, 48, 162, 193, 199, 181, 20], 
	[213, 77, 47, 135, 224, 28, 252, 12]
	)
weights_L3 = (
	[114, 57, 252, 135, 6, 61, 183, 17],
    [10, 71, 247, 1, 183, 3, 216, 22],
    [140, 13, 20, 251, 133, 178, 116, 12],
    [61, 80, 98, 27, 132, 40, 72, 19],
    [83, 68, 143, 31, 230, 160, 53, 14]
	)

# Biases
biases_L2 = [29, 129, 134, 185, 129, 156, 211, 17]
biases_L3 = [219, 217, 10, 120, 107]


# Set test data
test_no = 0
inputs_L2 = test_inputs[test_no]
print("Inputs: ", inputs_L2)

# Convert inputs to bipolar floats
x_bi = [prob_int_to_bipolar(x) for x in inputs_L2]
print("x_bi = ", x_bi)

# Calculate layer2 outputs
L2_out = []
for i in range(8):
	# Convert weights probs to bipolar floats
	w_bi = [prob_int_to_bipolar(w) for w in weights_L2[i]]
	# Convert bias to bipolar
	b_bi = prob_int_to_bipolar(biases_L2[i])
	# Input to neuron i
	L2_out.append( Neuron(x_bi, w_bi, b_bi) )

print("L2_out = ", L2_out)
print("L2_out prob int =", [bipolar_to_prob_int(y) for y in L2_out])

# Calculate layer3 outputs
"""
L3_out = []
for i in range(5):
	# Convert weights and bias to bipolar
	w_bi = [prob_int_to_bipolar(w) for w in weights_L3[i]]
	b_bi = prob_int_to_bipolar(biases_L3[i])
	# Input to neuron
	L3_out.append( Neuron(L2_out, w_bi, b_bi) )

# Results
print("L3_out = ", L3_out)

# Display result in integer probability form
print("L3_out prob int = ", [bipolar_to_prob_int(y) for y in L3_out])
"""