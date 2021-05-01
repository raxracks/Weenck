@echo off

echo Builder Script for Blueshift

echo Assemble BootFirstStage
nasm BootFirstStage.asm -f bin -i src -o BootFirstStage.bin

echo Assemble BootSecondStage
nasm BootSecondStage.asm -f elf64 -i src -o BootSecondStage.o