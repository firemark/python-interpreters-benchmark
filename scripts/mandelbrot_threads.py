from sys import argv, exit
from threading import Thread
from collections import deque

len_threads = int(argv[1])
height = 1600 
width = 1200 

len_parts = 16
part_height = height // len_parts
n = 256

L = [None] * len_parts 
part_nums = deque(range(len_parts))


def seek_point(x, y):
    p = complex(3.0 * x / width - 2.0, 2.0 * y / height - 1.0)
    z = complex(.0, .0)
    for i in xrange(n):
        z = z * z + p
        if abs(z) >= 2.0:
            break
    return i


def part_of_fractal(part_num):
    y_shift = part_height * part_num 
    return [
        seek_point(x, y)
        for y in xrange(y_shift, y_shift + part_height)
        for x in xrange(width)
    ]   


def compute():
   while True:
       try:
           part_num = part_nums.pop()
       except IndexError:
           break
       L[part_num] = part_of_fractal(part_num)

threads = [ 
    Thread(target=compute) 
    for _ in xrange(len_threads)
]

for thread in threads:
    thread.start()

for thread in threads:
    thread.join()

with open('/tmp/mandelbrot-image-%s' % n, 'w') as f:
    f.write(','.join(
        ','.join(str(i) for i in l) for l in L
    ))

