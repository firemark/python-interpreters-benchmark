#code from https://github.com/serge-sans-paille/numpy-benchmarks
import math
import numpy as np
import sys

def fft(x):
    N = x.shape[0]
    if N == 1:
        return np.array(x)
    e=fft(x[::2])
    o=fft(x[1::2])
    M=N//2
    l=[ e[k] + o[k]*math.e**(-2j*math.pi*k/N) for k in xrange(M) ]
    r=[ e[k] - o[k]*math.e**(-2j*math.pi*k/N) for k in xrange(M) ]
    return np.array(l+r)

NN = 2 ** int(sys.argv[1])
a = np.array(np.random.rand(NN), dtype=complex)
fft(a)

