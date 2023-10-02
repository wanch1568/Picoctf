unzip Forensics\ is\ fun.pptm
cd ppt/slideMasters
cat hidden | sed "s/ //g" | base64 --decode
