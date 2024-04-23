import matplotlib.pyplot as plt
import re
import numpy as np
from sklearn.metrics import mean_squared_error
from sklearn.metrics import mean_absolute_error

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

data_vivado = {"Test": [], "Results": []}
data_python = {"Test": [], "Results": []}

regexp = re.compile(r"Test:\s+(?P<test>\d+), Results:\s+(?P<n0>\d+),\s+(?P<n1>\d+),\s+(?P<n2>\d+),\s+(?P<n3>\d+),\s+(?P<n4>\d+)")

# Read vivado simulation file
with open("C:\\Users\\Rory\\Documents\\HDL\\Stochastic\\Stochastic.sim\\sim_1\\behav\\xsim\\NN_data.txt", "r+") as f:
	for line in f:
		m = regexp.search(line)
		data_vivado["Test"].append(int(m.group('test')))
		result_N0 = int(m.group('n0'))
		result_N1 = int(m.group('n1'))
		result_N2 = int(m.group('n2'))
		result_N3 = int(m.group('n3'))
		result_N4 = int(m.group('n4'))
		data_vivado["Results"].append([result_N0, result_N1, result_N2, result_N3, result_N4])

# Read python file
with open("C:\\Users\\Rory\\Documents\\HDL\\Stochastic\\Python\\NN_python_data.txt", "r+") as f:
	for line in f:
		m = regexp.search(line)
		data_python["Test"].append(int(m.group('test')))
		result_N0 = int(m.group('n0'))
		result_N1 = int(m.group('n1'))
		result_N2 = int(m.group('n2'))
		result_N3 = int(m.group('n3'))
		result_N4 = int(m.group('n4'))
		data_python["Results"].append([result_N0, result_N1, result_N2, result_N3, result_N4])


def plot_data():
	plt.figure(1)
	x_pts = []
	y_pts = []
	for i in range(100):
		x_pts.append([prob_int_to_bipolar(x) for x in data_python["Results"][i]])
		y_pts.append([prob_int_to_bipolar(y) for y in data_vivado["Results"][i]])
	plt.scatter(x_pts, y_pts)
	plt.grid(True)

	# Plot MSE over each test
	plt.figure(2)
	MSE_arr = []
	for i in range(100):
		mse = mean_absolute_error(x_pts[i], y_pts[i])
		MSE_arr.append(mse)
	x_vals = [j for j in range(100)]
	print(MSE_arr)
	plt.plot(x_vals, MSE_arr)
	plt.ylim(0, 1)
	plt.grid(True)
	plt.title("Mean-absolute Error for each test")
	plt.xlabel("Test no.")
	plt.ylabel("MAE")


plot_data()
plt.show()