;Blueshift "Bootloader"

[bits 32]
;Let the multiboot stuff handle the switch to 32 bit
global start
extern _kernel_main 

section .mbHeader
   align 0x4
   MODULEALIGN equ  1<<0                   ; align loaded modules on page boundaries
   MEMINFO     equ  1<<1                   ; provide memory map
   FLAGS       equ  MODULEALIGN | MEMINFO  ; this is the Multiboot 'flag' field
   MAGIC       equ    0x1BADB002           ; 'magic number' lets bootloader find the header
   CHECKSUM    equ -(MAGIC + FLAGS)        ; checksum required

MultiBootHeader:
   dd MAGIC
   dd FLAGS
   dd CHECKSUM


%include "Blueshift/IDT.asm"

start: ;start symbol is named in linker.ld

   push ebx ;what is this?
   call _kernel_main
   hlt