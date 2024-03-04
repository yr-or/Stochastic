
# Small scale NN, just using the standard operations, non-negative values
# 10 neurons in Layer 2, 5 in layer 3, max-value function, no pooling stage.

# Inputs and weights
def Neuron(x: list, w: list, b: int):
	# MulAcc operation
	mul = [x[i]*w[i] for i in range(len(x))]
	acc = sum(mul)
	# Add bias
	bias_out = acc + b
	# Apply activation function
	if (bias_out >= 0):
		relu_out = bias_out
	else:
		relu_out = 0
	return relu_out

# Contains all Neurons in layer 2
# hardcoded weights and biases
def Layer2(x: list):
	# 10 Neurons
	W_L2 = [ [1,2,3,4,5], [] ]



x = [1,2,3,4,5]
w = [5,4,3,2,1]

print(Neuron(x,w,5))