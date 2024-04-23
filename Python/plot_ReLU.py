import matplotlib.pyplot as plt
import re
import numpy as np
from sklearn.metrics import mean_squared_error

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


inps = []
outs = []

regexp = re.compile(r"Input:\s+(?P<input>\d+), Output:\s+(?P<output>\d+)")
with open("C:\\Users\\Rory\\Documents\\HDL\\Stochastic\\Stochastic.sim\\sim_1\\behav\\xsim\\relu_data.txt", "r+") as f:
	for line in f:
		m = regexp.search(line)
		inps.append(int(m.group('input')))
		outs.append(int(m.group('output')))

x_bi = [prob_int_to_bipolar(x) for x in inps]
y_uni = [int_to_unipolar(y) for y in outs]

plt.figure(1)
plt.scatter(inps, outs)
plt.grid(True)

plt.figure(2)
# Plot input values against output
plt.scatter(x_bi, y_uni, label="ReLU FSM")
plt.grid(True)
plt.xlabel("Input value")
plt.ylabel("Output value")
plt.title("ReLU output data")

# Plot actual function with lines
relu_x_pts = np.linspace(-1, 1, 100)
relu_y_pts = [0]*50 + list(np.linspace(0,1,50))
plt.plot(relu_x_pts, relu_y_pts, 'r', label="ReLU exact")

# Get MSE
relu_x_pts = np.array(x_bi)
relu_y_pts = np.where(relu_x_pts > 0, relu_x_pts, 0)
mse = mean_squared_error(relu_y_pts, y_uni)
print("MSE =", mse)

plt.legend()
plt.show()