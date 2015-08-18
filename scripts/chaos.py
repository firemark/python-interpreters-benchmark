#from https://gist.github.com/aliles/1087520#file-chaos-py
"Logistic map iteration timing"
from itertools import islice
import time


def logistic_map(r, x):
    assert r > 0, 'R must be a positive number'
    assert 0 < x < 1, 'X must be a number between 0 and 1'
    while True:
        x = r * x * (1 - x)
        yield x

if __name__ == '__main__':
    times = []
    minimum = float("inf")
    maximum = float("-inf")
    iterator = logistic_map(3.65, 0.01)
    for loop in xrange(15):
        start = time.clock()
        for x in islice(iterator, 500):
            minimum = min(minimum, x)
            maximum = max(maximum, x)
        stop = time.clock()
        times.append(stop - start)
    print "Iteration times"
    print ",".join(str(i * 10**3) for i in times)
    print "X range"
    print minimum, maximum
