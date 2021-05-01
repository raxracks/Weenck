nasm -f elf boot.asm -o boot.o
g++ -c kernel.cpp -o kernel.o -ffreestanding -fno-exceptions -fno-rtti

ld -T linker.ld -o kernel boot.o kernel.o -build-id=none
objcopy -O elf32-i386 kernel kernel.elf

qemu-system-i386 -kernel kernel.elf