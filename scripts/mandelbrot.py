from sys import argv, exit

height = int(argv[1])
width = int(argv[2])
n = int(argv[3]) 


def seek_point(x, y):
    p = complex(3.0 * x / width - 2.0, 2.0 * y / height - 1.0)
    z = complex(.0, .0)
    for i in range(n):
        z = z * z + p
        if abs(z) >= 2.0:
            return i

l = []
for y in xrange(height):
    for x in xrange(width):
        l.append(seek_point(x, y))
