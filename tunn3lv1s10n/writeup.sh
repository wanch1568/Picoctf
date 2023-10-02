printf "\x28\x00" | dd of=tunn3l_v1s10n bs=1 seek=14 count=2 conv=notrunc
mv tunn3l_v1s10n tunn3l_v1s10n.bmp
printf "\x40\x03" | dd of=tunn3l_v1s10n.bmp bs=1 seek=22 count=2 conv=notrunc
