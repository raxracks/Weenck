PROGRAM_SPACE equ 0x8000                                ; Set the PROGRAM_SPACE macro to 

ReadDisk:
    mov ah, 0x02                                        ; Read sectors
    mov bx, PROGRAM_SPACE                               ; 
    mov al, 128                                          ; Sectors to read count
    mov dl, [BOOT_DISK]                                 ; Drive to read from
    mov ch, 0x00                                        ; Cylinder
    mov dh, 0x00                                        ; Head
    mov cl, 0x02                                        ; Sector

    int 0x13                                            ; Low Level Disk Services
    ;jc DiskReadFailed                                   ; If the operation failed it will set the carry register, check that or whatevs

    ret

BOOT_DISK: db 0

DiskReadErrorString: db 'Disk Read Failed', 0

DiskReadFailed:
    mov bx, DiskReadErrorString
    call printString

    jmp $