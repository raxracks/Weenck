gdt_nulldesc:
    dd 0 ;declare double 
    dd 0

gdt_codedesc:
    dw 0xFFFF ;Limit
    dw 0x0000 ;Base (low)
    db 0x00   ;Base (medium)
    db 10011010b       ;Access byte (Present, Privilege, Descriptor Type , Executable, Direction, RW, Ac)
    db 11001111b ; granularity - 4k blocks, size - 32 bit protected mode, 2 unused bits, upper limit
    db 0x00

gdt_datadesc:
    dw 0xFFFF ;Limit
    dw 0x0000 ;Base
    db 0x00   ;Base part 2
    db 10010010b       ;Access byte (Present, Privilege (2b), Descriptor Type , Executable, Direction, RW, Ac)
    db 11001111b ; granularity - 4k blocks, size - 32 bit protected mode, 2 unused bits, upper limit
    db 0x00

gdt_end:

gdt_descriptor:
    gdt_size: dw gdt_end - gdt_nulldesc - 1
    dd gdt_nulldesc

codeseg equ gdt_codedesc - gdt_nulldesc
dataseg equ gdt_datadesc - gdt_nulldesc

[bits 32]

EditGDT:
    mov [gdt_codedesc + 6], byte 10101111b
    mov [gdt_datadesc + 6], byte 10101111b
    ret

[bits 16]