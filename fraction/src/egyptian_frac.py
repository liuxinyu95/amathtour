#!/usr/bin/python3

import queue

def gcd(a, b):
    if a < b:
        a, b = b, a
    while b != 0:
        a, b = b, a % b
    return a

def frac_reduce(b, a):
    d = gcd(b, a)
    return (b // d, a // d)

def compare(xs, ys):
    if not xs:
        return ys
    elif not ys:
        return xs
    elif len(xs) < len(ys):
        return xs
    elif len(ys) < len(xs):
        return ys
    elif xs[0] < ys[0]:
        return xs
    else:
        return ys

# Decompose b/a within n Egyptian (unit) fractions (0 < b < a, irreducible).
def decompose(b, a):
    if b == 1:
        return [a]
    n, best = b, []
    cs = queue.Queue()
    cs.put((b, a, []))
    while not cs.empty():
        b, a, qs = cs.get()
        m = n - len(qs)
        low = max(a // b + 1, qs[0] + 1 if qs else 0)
        for q in range(low, a + 1):
            if best != [] and len(qs) >= len(best) - 1:
                return best
            if a*m < b*q: # m/q < b/a
                break     # b/a can not be decomposed within n fractions <= 1/q
            b1, a1 = frac_reduce(b*q - a, a*q)        # b'/a' = b/a - 1/q
            if b1 == 1 and a1 > q:
                best = compare([a1, q] + qs, best)
            else:
                cs.put((b1, a1, [q] + qs))
    return best

# Fibonacci decomposition (greedy method)
def fibonacci_decompose(b, a):
    qs = []
    while b != 1:
        q = a // b + 1
        qs.append(q)
        b, a = frac_reduce(b*q - a, a*q)
    qs.append(a)
    return qs

def verify(b, a):
    qs1 = fibonacci_decompose(b, a)
    print(f"Fibonacci decompose of {b}/{a}: {qs1}")
    qs2 = decompose(b, a)
    print(f"best decompose: {qs2}")
    b1, a1 = 0, 1
    for q in qs2:
        b1, a1 = frac_reduce(b1*q + a1, a1 * q) #b1/a1 + 1/q
    print(f"sum to: {b1}/{a1}")
    assert(b1 == b and a1 == a)
    assert(len(qs2) <= len(qs1))

if __name__ == "__main__":
    verify(1, 2)    # ==> [2]
    verify(7, 8)    # ==> [8, 4, 2]
    verify(5, 121)  # ==> [363, 121, 33]
