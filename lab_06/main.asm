PUBLIC number

PUBLIC newline


EXTRN scan_u16  :   near
EXTRN print_u2  :   near
EXTRN print_s8  :   near


SSEG SEGMENT STACK 'STACK'
    db 100h dup ('s')
SSEG ENDS


DSEG SEGMENT PUBLIC 'DATA'
    number      dw  0
    mes_menu    db  "Menu:", 0Dh, 0Ah,
                    "1.  Input unsigned hex number", 0Dh, 0Ah,
                    "2. Output unsigned bin number", 0Dh, 0Ah,
                    "3. Output   signed oct number", 0Dh, 0Ah,
                    0Dh, 0Ah,
                    "0. Exit", 0Dh, 0Ah,
                    0Dh, 0Ah,
                    "Your choice: ", "$"
    mes_exit    db  "Exit", 0Dh, 0Ah, "$"
    mes_endl    db  0Dh, 0Ah, "$"
    arr_f       dw  exit_menu, scan_u16, print_u2, print_s8
DSEG ENDS


CSEG SEGMENT PUBLIC 'CODE'
newline proc near
    mov dx, offset mes_endl
    mov ah, 09h
    int 21h

    ret
newline endp

exit_menu proc near
    mov dx, offset mes_exit
    mov ah, 09h
    int 21h

    mov ah, 4Ch
    int 21h
exit_menu endp

    assume ds:DSEG
main:
    mov ax, DSEG
    mov ds, ax

    mov dx, offset mes_menu
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h
run_menu:
    call newline

    sub al, '0'
    shl al, 1
    xor ah, ah
    mov bx, ax

    call newline
    call arr_f[bx]
    call newline

    mov dx, offset mes_menu
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h

    jmp run_menu
CSEG ENDS


END main
