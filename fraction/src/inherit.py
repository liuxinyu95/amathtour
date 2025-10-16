#!/usr/bin/python3

def inherit():
    s = []
    for a in range(2, 11):
        for b in range(a + 1, 12):
            for c in range(b + 1, 13):
                d = a*b*c - a*b - b*c - a*c
                if d > 0:
                    n = a*b*c // d
                    if n % a == 0 and n % d == 0 and n % c == 0:
                        s.append((a, b, c))
    return s

if __name__ == "__main__":
    print(inherit())
