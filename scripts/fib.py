from sys import argv

def fib(n):
    if n <= 2:
        return 1
    else:
        return fib(n - 1) + fib(n - 2)

_, n, correct_result = argv
result = fib(int(n))
if result == int(correct_result):
    print('OK')
else:
    print('{} != {}'.format(result, correct_result))
