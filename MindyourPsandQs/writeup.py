import math
with open("./values","r") as f:
    for line in f:
        line=line.strip()
        if line[0]=='c':
            c=int(line[2:])
        elif line[0]=='n':
            n=int(line[2:])
        elif line[0]=='e':
            e=int(line[2:])
#factordbでnを因数分解
p=1617549722683965197900599011412144490160
q=475693130177488446807040098678772442581572
d=pow(e,-1,p*q)
print(bytes.fromhex((hex(pow(c,d,n)))[2:]).decode("utf-8"))
#c=m^e(mod n)
#n=p*q
#m=c^d(mod n)
#d=1/e mod((p-1)(q-1))
#c: 8533139361076999596208540806559574687666062896040360148742851107661304651861689
#nは通常2048ビットなどだがこれはおよそ266ビット
#factordbで進数分解
#n: 769457290801263793712740792519696786147248001937382943813345728685422050738403253
#n=81桁≒266ビット
#e: 65537
