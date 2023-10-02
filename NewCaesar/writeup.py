c="mlnklfnknljflfjljnjijjmmjkmljnjhmhjgjnjjjmmkjjmijhmkjhjpmkmkmljkjijnjpmhmjjgjj"
base=ord("a")
chars=""
res=""
for rot in range(0,16):
    for i,n in enumerate(c):
        chars+="{0:04b}".format((ord(n)-rot-base)%16)
        
        if i%2==1:
            res+=chr(int(chars,2))
            chars=""
    print(res+"\n\n")
    res=""
    chars=""
#実行結果のなかでflagっぽい文字列をpicoCTF{}でラップする
        