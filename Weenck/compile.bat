nasm -f elf Blueshift\boot.asm -o bin\boot.o
g++ -c Entry\kernel.cpp -o bin\kernel.o -ffreestanding -fno-exceptions -fno-rtti

ld -T Blueshift\linker.ld -o bin\kernel bin\boot.o bin\kernel.o -build-id=none
objcopy -O elf32-i386 bin\kernel bin\kernel.elf

qemu-system-i386 -kernel bin\kernel.elf