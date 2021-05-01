;[org 0x7e00]                                                            ; Offset to +512 bytes from where the BIOS loads our boot sector 
;We're doing this in the linker now

[bits 16] 
jmp EnterProtectedMode ;skip over the include directives (they contain code we don't want to call right now)

%include "gdt.asm"
%include "DetectMemory.asm"

EnterProtectedMode: ;Steps needed to enter 32bit Protected mode. 
    call DetectMemory
    call EnableA20 
    cli ;disable interrupts
    lgdt [gdt_descriptor] ;load gdi

    mov eax, cr0 ;set protected mode bit
    or eax, 1
    mov cr0, eax

    jmp codeseg:StartProtectedMode ;Jump to protected mode (far jump, flashes CPU stuff)


EnableA20:
    in al, 0x92 ;port in, save in al
    or al, 2 ;set second lowest bit to 1 (so 0000 becomes 0010 )
    out 0x92, al ;port out from al
    ret


[bits 32] ;The following code is in 32bit

%include "CPUID.asm"
%include "identityPaging.asm"

StartProtectedMode:
    mov ax, dataseg ;put the datasegment of the GDT in ax, ds, ss, es, fs, gs
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    call DetectCPUID
    call DetectLongMode
    call SetUpIdentityPaging
    call EditGDT

    jmp codeseg:Start64Bit

[bits 64]
[extern _start] ;The _start function in Kernel.cpp

%include "IDT.asm"

Start64Bit:

    ;mov edi, 0xb8000 ;Set the writing address to the VGA starting address
    ; mov edi, 0xA0000
    ; mov rax, 0x1f201f201f201f20 ;Data to repeat in VGA mem (1f - SPACE, 20- BLUE)
    ; mov ecx, 500 ;Repeat 500 times
    ; rep stosq

    call ActivateSSE 
    
    call _start ;Entry point of main kernel

    jmp $

ActivateSSE: ;Streaming SIMD Extensions - adds extra instructions to the CPU
    mov rax, cr0
    and ax, 0b11111101
    or ax, 0b00000001
    mov cr0, rax

    mov rax, cr4
    or ax, 0b1100000000
    mov cr4, rax
    ret

times 2048 db 0 ;2048 * 512 ??