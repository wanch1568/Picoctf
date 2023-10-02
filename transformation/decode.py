import sys

result=""
for line in sys.stdin:
    for i in line:
        result+=chr(int(bin(ord(i)>>8),2))
        result+=chr(int(bin(ord(i)& 0b11111111) ,2))
print(result)