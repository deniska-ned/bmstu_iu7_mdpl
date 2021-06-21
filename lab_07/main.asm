.MODEL TINY
.186

CODES SEGMENT
    assume cs:codes, ds:codes
    org 100H

main:
    jmp init
    cur_sec     db ?
    speed       db 11111b
    old_handler dd ?


new_08_handler proc
    pusha
    push es
    push ds

    mov ah, 02h
    int 1ah

    cmp dh, cur_sec
    mov cur_sec, dh
    je fin_08_handler

    mov al, 0f3h
    out 60h, al
    mov al, speed
    out 60h, al

    dec speed
    cmp speed, 0
    jne fin_08_handler

    mov speed, 11111b
fin_08_handler:
    pop ds
    pop es

    popa

    jmp CS:old_handler
new_08_handler endp


init:
    mov AX, 3508h
    int 21h

    mov word ptr old_handler, bx
    mov word ptr old_handler + 2, es

    mov AX, 2508h
    mov DX, offset new_08_handler
    int 21h

    mov DX, offset init
    int 27H

CODES ENDS
END main
