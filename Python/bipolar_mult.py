
def prob_to_bipolar(x):
	return (2*x)-1

def bipolar_to_prob(y):
	return (y+1)/2

num1_int = 192
num2_int = 64
num1_bi = prob_to_bipolar(num1_int/256)
num2_bi = prob_to_bipolar(num2_int/256)
print(f"num1_bi = {num1_bi}")
print(f"num2_bi = {num2_bi}")

res = num1_bi*num2_bi
res_prob = bipolar_to_prob(res)
res_int = res_prob*256
print(f"result = {prob_to_bipolar(res_int/256)}")
print(f"res_int = {res_int}")

# Unipolar
print(f"num1_int = ")