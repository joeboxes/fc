# README.md

## bootloader



#### create virtual hdd
```
VBOX > NEW > bootloader | linux | ubunt-32-bit > create > VHD > Fixed > 2048
```

#### install nasm compiler
```
sudo apt-get install nasm
```

#### compile assembly into binary
```
nasm -f bin -o bootloader.bin bootloader.nasm
```

#### put bootloader on virtual disk
```
dd conv=notrunc bs=512 count=1 if=bootloader.bin of=bootloader.vhd
```




### References
```
http://wiki.osdev.org/Rolling_Your_Own_Bootloader
http://mikeos.sourceforge.net/write-your-own-os.html
http://wiki.osdev.org/Ralf_Brown%27s_Interrupt_List

```
