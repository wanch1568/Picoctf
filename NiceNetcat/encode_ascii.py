import sys

result = []

for line in sys.stdin:
    value = int(line.strip())
    result.append(chr(value))

print(''.join(result))

