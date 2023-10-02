exiftool cat.jpg | grep License | sed s/^.*:.//g | base64 --decode
