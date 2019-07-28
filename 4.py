def fact(n):
    res = n
    while n > 1:
        n -= 1
        res *= n
    return res
