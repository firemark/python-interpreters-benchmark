from sys import argv, exit

def fib(n):
    if n <= 2:
        return 1
    return fib(n - 1) + fib(n - 2)

n = int(argv[1])
correct_result = int(argv[2])
if fib(n) != correct_result:
    exit(-1)
