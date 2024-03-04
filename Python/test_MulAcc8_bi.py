
def prob_to_bipolar(x):
	return (2*x)-1

def prob_int_to_bipolar(x):
	return prob_to_bipolar(x/256)

def bipolar_to_prob(y):
	return (y+1)/2

def bipolar_to_prob_int(y):
	return int(bipolar_to_prob(y)*256)


x = [182, 59, 17, 134, 155, 116, 48, 147]
w = [3, 149, 145, 141, 174, 165, 225, 106]

# Get bipolar values
x_bi = [prob_int_to_bipolar(i) for i in x]
w_bi = [prob_int_to_bipolar(i) for i in w]
print("x_bi = ", x_bi)
print("w_bi = ", w_bi)

# Multiply
mul = [x_bi[i]*w_bi[i] for i in range(len(x_bi))]
print("mul = ", mul)

# Sum pairs and /2
add_1 = [ (mul[i*2]+mul[(i*2)+1])/2 for i in range(4) ]
add_2 = [ (add_1[i*2]+add_1[(i*2)+1])/2 for i in range(2) ]
print("add1 = ", add_1)
print("add2 = ", add_2)


# Result
res = (add_2[0] + add_2[1])/2
print("Result = ", res)

# Display result in integer probability form
print("result prob int = ", bipolar_to_prob_int(res))