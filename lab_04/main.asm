EXTRN print_diff: far
EXTRN buffersize: far

SSSTK SEGMENT para STACK
    db 100h dup(0)
SSSTK ENDS

SD_MES SEGMENT para
    new_line db 0Dh,0Ah,'$'
SD_MES ENDS

SCMAIN SEGMENT para
    assume CS:SCMAIN, SS:SSSTK
main:
    mov ax, seg buffersize
    mov ds, ax

    mov dx, OFFSET buffersize
    mov ah, 0Ah
    int 21h

    assume DS:SD_MES
    mov ax, SD_MES
    mov ds, ax

    mov dx, OFFSET new_line
    mov ah, 09h
    int 21h

    jmp print_diff
SCMAIN ENDS

END main
