[extern _idt]
idtDescriptor:
    dw 4095
    dq _idt

; %macro PUSHALL 0 ;64 bit mode is stupid and doesn't have pusha and popa instructions
;     push rax
;     push rcx
;     push rdx
;     push r8
;     push r9
;     push r10
;     push r11
; %endmacro

; %macro POPALL 0
;     pop r11
;     pop r10
;     pop r9
;     pop r8
;     pop rdx
;     pop rcx
;     pop rax
; %endmacro

[extern isr1_handler]
isr1: ;Keyboard
    ;PUSHALL
    pushad
    call isr1_handler
    popad
    ;POPALL
    iretq 
    GLOBAL isr1