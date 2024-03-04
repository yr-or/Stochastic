import random

inputs = [182, 64, 17, 134, 155, 116, 48, 147]
weights = [3, 149, 145, 141, 174, 165, 225, 106]

inputs_px = [i/256 for i in inputs]
inputs_bi = [(2*i)-1 for i in inputs_px]
inputs_bi_int = [int(i*256) for i in inputs_bi]

print(f"inputs prob:\t\t\t  {inputs_px}")
print(f"inputs bipolar value:\t  {inputs_bi}")
print(f"inputs bipolar int value: {inputs_bi_int}")

# Convert int number into stoch int prob.
prob_int = 64  # Should be = -0.5
num_int = (2*prob_int)-256
print(f"{num_int=}")
num_real = num_int/256
print(num_real)

# Convert stoch prob to bipolar number
num_int = 0
prob_int = (num_int/2)+128
prob_real = prob_int/256
print(prob_real)