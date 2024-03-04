
inps = [182, 59, 17, 134, 155, 116, 48, 147]
wghts = [3, 149, 145, 141, 174, 165, 225, 106]

inps_p = [i/256 for i in inps]
wghts_p = [i/256 for i in wghts]


mul = []
for i in range(len(inps)):
	mul.append( inps_p[i]*wghts_p[i] )

print(f"Mul binary vals: {[i*256 for i in mul]}")
print(f"Mul float vals: {mul}")

add_1 = [ (mul[i*2]+mul[(i*2)+1])/2 for i in range(4) ]
add_2 = [ (add_1[i*2]+add_1[(i*2)+1])/2 for i in range(2) ]

print(f"Add1 binary vals: {[i*256 for i in add_1]}")
print(f"Add2 binary vals: {[i*256 for i in add_2]}")

res = (add_2[0] + add_2[1])/2
print(f"Res binary: {res*256}")