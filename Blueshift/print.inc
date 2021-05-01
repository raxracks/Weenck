printString:                                    ; printString function | input - string in bx | output - void (prints string in bx to screen)
    mov ah, 0x0E                                ; Write Character in TTY Mode
    .loop:                                      ; Begin loop
    cmp [bx], byte 0x0                          ; Check if the byte at the address in bx is \0 (null string terminator)
    je .exit                                    ; Jump to the exit part if the condition is true, else continue
        mov al, [bx]                            ; Put the byte at the address in bx in the al register
        int 0x10                                ; Call BIOS "Video Services" interrupt - print to the screen
        inc bx                                  ; Increment the address stored in bx
        jmp .loop                               ; Jump back to the beginning of the loop
    .exit:                              
    ret                                         