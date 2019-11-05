def scaleIncrement(value, lower, upper, incr):
    if incr > 0:
        value = math.max(lower, (value + incr)%(upper + 1))
    elif incr < 0:
        value = (value + incr) % (upper + 1)
        while value <= 0:
            value = value + upper
    return value

print(scaleIncrement(1, 1, 4, -1))
