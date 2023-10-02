import string
alp_lower=string.ascii_lowercase
alp_upper=string.ascii_uppercase
other="0123456789+/"
base64char=alp_upper+alp_lower+other
print(base64char)
if "a" in base64char:
    ten=base64char.index("a")
    b=base64char.index("b")
    ten="0b"+bin(ten)[2:]
    print(bin(b))
    print(type(ten))
def Base64toAscii(s):
    for i in  s:
        print(i)