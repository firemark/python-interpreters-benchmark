import numpy as np

a = np.arange(512 * 512).reshape(512, 512)
b = np.eye(512, dtype=float)
for i in range(100):
    a[a % 2 == 0] *= 2
    a *= 1 + b
    m = a % 4 == 1
    a[m] *= np.arange(np.sum(m)) * 8
    b = np.sin(a) + a[5]  - a[:, 5]

print (int(np.sum(b[:,5])), int(np.sum(b[5])))
if (int(np.sum(b[:,5])), int(np.sum(b[5]))) != (-1, 18446744073709551616):
    exit(-1)

