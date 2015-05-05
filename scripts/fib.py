from sys import argv, exit

def fib(n):
    if n <= 2:
        return 1
    else:
        return fib(n - 1) + fib(n - 2)

_, n, correct_result = argv
if fib(int(n)) != int(correct_result):
    exit(-1)
