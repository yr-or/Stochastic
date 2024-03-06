import matplotlib.pyplot as plt
import re

def prob_to_bipolar(x):
	return (2*x)-1

def prob_int_to_bipolar(x):
	return prob_to_bipolar(x/256)

def bipolar_to_prob(y):
	return (y+1)/2

def bipolar_to_prob_int(y):
	return int(bipolar_to_prob(y)*256)

inps = []
outs = []

#inps = [0, 25, 50, 75, 100, 125, 150, 175, 200, 225]
#outs = [0, 5, 12, 31, 56, 71, 105, 144, 178, 210]

regexp = re.compile(r"Input:\s+(?P<input>\d+), Output:\s+(?P<output>\d+)")
with open("C:\\Users\\Rory\\Documents\\HDL\\Stochastic\\Stochastic.sim\\sim_1\\behav\\xsim\\relu_data.txt", "r+") as f:
	for line in f:
		m = regexp.search(line)
		inps.append(int(m.group('input')))
		outs.append(int(m.group('output')))

x_bi = [prob_int_to_bipolar(x) for x in inps]
y_uni = [y/256 for y in outs]

plt.plot(x_bi, y_uni)
plt.grid(True)
plt.show()




