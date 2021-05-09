;Blueshift Bootloader First Stage
;Must be 512 bytes long AT MOST. Your mileage might vary

[org 0x7c00]                                    ; Set the base address to 0x7c00 (where the BIOS puts our code) so other calls properly access the desired memory
[bits 16]

mov [BOOT_DISK], dl

mov bp, 0x7c00                                  ; Set the base of the stack to where the BIOS puts our boot sector code in memory
mov sp, bp                                      ; Set the top of the stack to the base. The stack expands downwards (towards 0x0 )

;mov bx, bootSuccessfulString                    ; Put the address of bootSuccessfulString in the bx
;call printString                                ; Call the printString function

call ReadDisk                                   ; Use sparingly, al register limit is 255 and I'm pretty sure the BIOS is dumb and only loads up to 128 segments

;WHERE IS PROGRAM_SPACE DEFINED?
jmp PROGRAM_SPACE                               ; Jump to the end of the second sector

%include "print.asm"                 ; include print.asm
%include "disk.asm"                  ; include disk.asm

times 510-($-$$) db 0                           ; Fill the rest of the file with enough bytes so the entire file is exactly 512 bytes long
dw 0xaa55                                       ; Magic number - tells the BIOS this is a boot sector