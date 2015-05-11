from sys import argv
from threading import Thread

def count(n):
    while n > 0:
        n -= 1

n = int(argv[2])
len_threads = int(argv[1])
threads = [
    Thread(target=count, args=(n // len_threads,)) 
    for _ in range(len_threads)
]
for thread in threads:
    thread.start()

for thread in threads:
    thread.join()
