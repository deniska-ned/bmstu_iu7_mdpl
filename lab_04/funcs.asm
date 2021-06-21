PUBLIC print_diff
PUBLIC buffersize

SDBUF SEGMENT para
    buffersize db 6h
    inputlen db 0
    buffer db 6h DUP('$')
SDBUF ENDS

SCFUNCS SEGMENT para
    assume CS:SCFUNCS, DS:SDBUF
print_diff:
    mov ax, SDBUF
    mov ds, ax

    mov dl, buffer + 1
    sub dl, buffer + 2
    add dl, 30h

    mov ah, 02h
    int 21h

    mov ax, 4c00h
    int 21h
SCFUNCS ENDS

END
