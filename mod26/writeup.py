s="cvpbPGS{arkg_gvzr_V'yy_gel_2_ebhaqf_bs_ebg13_Ncualgvd}"

def decode_rot13(s):
    result=""
    for char in s:
        if ord('a')<=ord(char) <=ord('z'):
            result += chr(ord("a")+(ord(char)-ord("a")-13)%26)
        elif ord('A')<=ord(char)<=ord('Z'):
            result += chr(ord("A")+(ord(char)-ord("A")-13)%26)
        else:
            result += char
    return result
print(decode_rot13(s))