import requests

res=requests.head("http://mercury.picoctf.net:53554/index.php")
if res.status_code==200:
    print(res.headers)