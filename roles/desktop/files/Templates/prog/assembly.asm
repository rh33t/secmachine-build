global _start

section .text

_start:
    mov eax, 0x4
    mov ebx, 0x1
    mov ecx, message
    mov edx, 0xF
    int 0x80

    mov eax, 0x1
    mov ebx, 0x0
    int 0x80

section .data
    message: db "time to cook !", 0dh, 0ah
