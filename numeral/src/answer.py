#!/bin/python3

from random import randint

def bin(n):
    bs = []
    while n > 1:
        bs = [n % 2] + bs
        n = n // 2
    return [n] + bs

def dec(bs):
    n = 0
    for b in bs:
        n = n*2 + b
    return n

def test():
    for _ in range(100):
        x = randint(0, 1000000)
        bs = bin(x)
        n = dec(bs)
        assert(n == x)
        print(f"bin of {n} is {bs}")
    print("passed 100 tests")

if __name__ == "__main__":
    test()
