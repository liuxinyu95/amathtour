#!/usr/bin/python3

#\tan^{-1} x = x - \frac{x^3}{3} + \frac{x^5}{5} - \frac{x^7}{7} + \dotsb
def gregory(x, n):
    s = 0
    xi = x
    for i in range(1, n + 1):
        s = s + xi / (2*i - 1)
        xi = - xi * x * x
    return s

def leibniz(n):
    return 4 * gregory(1, n)

def machin(n):
    return 4 * (4 * gregory(1/5, n) - gregory(1/239, n))

if __name__ == "__main__":
    n = 101
    print(f"Leibniz formula of {n} terms: {leibniz(n)}")
    print(f"Machin  formula of {n} terms: {machin(n)}")
