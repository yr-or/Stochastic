"""
Compare python and vivado simulations for adder
"""
import re
import matplotlib.pyplot as plt

data_vivado = {"Test": [], "Result": []}
data_python = {"Test": [], "Result": []}

regexp = re.compile(r"Test:\s+(?P<test>\d+), Result:\s+(?P<result>\d+)")

# Read vivado simulation file
with open("C:\\Users\\Rory\\Documents\\HDL\\Stochastic\\Stochastic.sim\\sim_1\\behav\\xsim\\Adder_test.txt", "r+") as f:
	for line in f:
		m = regexp.search(line)
		data_vivado["Test"].append(int(m.group('test')))
		data_vivado["Result"].append(int(m.group('result')))

# Read python file
with open("C:\\Users\\Rory\\Documents\\HDL\\Stochastic\\Python\\Adder_test_python.txt", "r+") as f:
	for line in f:
		m = regexp.search(line)
		data_python["Test"].append(int(m.group('test')))
		data_python["Result"].append(int(m.group('result')))

# Plot python data against vivado
plt.figure(1)
plt.scatter(data_python["Result"], data_vivado["Result"])
plt.xlabel("Python data")
plt.ylabel("Vivado data")
plt.title("Adder result")
plt.grid(True)

# Plot vivado data against its inputs

plt.show()