@echo off

echo Builder Script for Redshift

echo Compile Kernel.cpp
gcc -Ttext 0x8000 -ffreestanding -mno-red-zone -m32 -c "Kernel.cpp" -o "bin/Kernel.o"


echo Link stuff
ld -T"linker.ld"