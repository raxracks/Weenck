@echo off

echo Builder Script for Blueshift

echo Assemble BootFirstStage
nasm BootFirstStage.asm -f bin -i src -o bin/BootFirstStage.bin

echo Assemble BootSecondStage
rem nasm BootSecondStage.asm -f elf64 -i src -o bin/BootSecondStage.o
nasm BootSecondStage.asm -f elf64 -i src -o bin/BootSecondStage.o