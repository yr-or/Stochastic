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

def unipolar_to_int(x):
	return int(x*256)

def int_to_unipolar(x):
	return x/256

data_vivado = {"Test": [], "Result": [], "macc_out": [], "bias_out": []}
data_python = {"Test": [], "Result": [], "macc_out": [], "bias_out": []}


regexp = re.compile(r"Test:\s+(?P<test>\d+), Result:\s+(?P<result>\d+), macc_out:\s+(?P<macc_out>\d+), bias_out:\s+(?P<bias_out>\d+)")

# Read vivado simulation file
with open("C:\\Users\\Rory\\Documents\\HDL\\Stochastic\\Stochastic.sim\\sim_1\\behav\\xsim\\neuron8_test.txt", "r+") as f:
	for line in f:
		m = regexp.search(line)
		data_vivado["Test"].append(int(m.group('test')))
		data_vivado["Result"].append(int(m.group('result')))
		data_vivado["macc_out"].append(int(m.group('macc_out')))
		data_vivado["bias_out"].append(int(m.group('bias_out')))

# Read python file
with open("C:\\Users\\Rory\\Documents\\HDL\\Stochastic\\Python\\neuron8_test_python.txt", "r+") as f:
	for line in f:
		m = regexp.search(line)
		data_python["Test"].append(int(m.group('test')))
		data_python["Result"].append(int(m.group('result')))
		data_python["macc_out"].append(int(m.group('macc_out')))
		data_python["bias_out"].append(int(m.group('bias_out')))

# Plot outputs in subplot
plt.figure(1)
# Plot macc_outs
plt.subplot(2,2,1)
plt.scatter(data_python["macc_out"], data_vivado["macc_out"])
plt.xlabel("Python data")
plt.ylabel("Vivado data")
plt.title("macc_out")
plt.grid(True)

# Plot the bias_out data
plt.subplot(2,2,2)
plt.scatter(data_python["bias_out"], data_vivado["bias_out"])
plt.xlabel("Python data")
plt.ylabel("Vivado data")
plt.title("bias_out")
plt.grid(True)

# Plot the final results data
plt.subplot(2,2,3)
plt.scatter(data_python["Result"], data_vivado["Result"])
plt.xlabel("Python data")
plt.ylabel("Vivado data")
plt.title("Results")
plt.grid(True)

# Compare ReLU functions
plt.figure(2)
plt.subplot(1,2,1)
plt.scatter(data_python["bias_out"], data_python["Result"])
plt.xlabel("Python bias_out")
plt.ylabel("Python relu_out")
plt.title("Python ReLU comparison")
plt.grid(True)

plt.subplot(1,2,2)
bias_out_vivado_real = [prob_int_to_bipolar(x) for x in data_vivado["bias_out"]]
relu_out_vivado_real = [int_to_unipolar(x) for x in data_vivado["Result"]]
plt.scatter(bias_out_vivado_real, relu_out_vivado_real)
plt.xlabel("Vivado bias_out")
plt.ylabel("Vivado relu_out")
plt.title("Vivado ReLU comparison")
plt.grid(True)

plt.show()