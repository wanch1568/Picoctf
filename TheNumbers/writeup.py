import string
alp=string.ascii_lowercase
numbers=[16,9,3,15,3,20,6,0,20,8,5,14,21,13,2,5,18,19,13,1,19,15,14,-1]
res=""
for i in numbers:
    if i==0:
        res+="{"
    elif i==-1:
        res+="}"
    else:
        res+=alp[i-1]
print(res.replace("ctf","CTF"))