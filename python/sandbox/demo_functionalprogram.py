a = [1, 2, 3, 4, 5]

def sqr(x):
    return x * x

def is_even(x):
    return x % 2 == 0

def add(x, y):
    return x + y


print map(sqr, a)
print filter(is_even, a)
print map(is_even, a)

print reduce(add, a)

print reduce(lambda x, y : x+y, a)
print filter(lambda x : x % 2 == 0, a)