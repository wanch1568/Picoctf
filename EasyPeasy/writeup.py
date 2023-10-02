import socket

host = "mercury.picoctf.net"
port = 36449


with socket.socket(socket.AF_INET,socket.SOCK_STREAM) as s:
    #ソケットを作成して通信
    s.connect((host,port))
    s.settimeout(10)
    #一回データを送信したらTrueにする
    is_sent=False
    recieved_data = b""
    encrypted_flag=""
    encrypted_data=""
    print(bin(ord("a")))
    print(bin(int("03",16)))
    print(bin(ord("a")^int("03",16)))
    print(int(bin(ord("a")^int("03",16)),2))
    while True:
        chunk=s.recv(4096)
        if not chunk:
            print("no chunk")
            break
        recieved_data += chunk
        #もし受信データ中に"encrypt?"があった場合、すでにデータを送信してるかどうかで条件分岐
        if b"encrypt?" in recieved_data :
            if is_sent:
                encrypted_data=recieved_data.decode("utf-8").split("\n")[1]
                #print(encrypted_data)
                #encrypted_dataの後ろからlen(flag)分文字を取り出す
                #key_aはkeyとaの排他的論理和
                key_a=encrypted_data[-len(encrypted_flag):].replace(" ","")
                
                key=[]
                #もう一回aとの排他的論理和をとることでkeyを復元
                for i in range(0,len(key_a),2):
                    key.append(int(key_a[i:i+2],16)^ord("a"))
                
                res=int(encrypted_flag[0:2],16)^key[0]
                res=""
                for i in range(2,len(encrypted_flag),2):
                    res+=str(int(encrypted_flag[i:i+2],16)^key[i//2])+":"
                print(encrypted_flag)
                print(key)
                print(res)
                print(key_a)
                
                print("finish")
                break
            else:
                encrypted_flag = recieved_data.decode("utf-8").split("\n")[2].replace(" ","")
                print("encrypted flag is "+encrypted_flag)
                s.sendall(("a"*50000+"\n").encode())
                recieved_data=b""
                
                is_sent=True
        