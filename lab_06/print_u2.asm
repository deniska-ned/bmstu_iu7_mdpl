.186


PUBLIC print_u2


EXTRN number    :   word

EXTRN newline   :   near


DSEG SEGMENT PUBLIC 'DATA'
    bin_mask    dw  8000h
    bin_prefix  db  "0b$"
DSEG ENDS


CSEG SEGMENT PUBLIC 'CODE'
assume ds:dseg

print_u2 proc near
    mov bx, number

    mov dx, offset bin_prefix
    mov ah, 09h
    int 21h

    mov cx, 10h
print_u2_digit:
    mov dx, bin_mask
    and dx, bx

    shr dx, 0Fh

    add dl, '0'
    mov ah, 02h
    int 21h

    shl bx, 1
    loop print_u2_digit

    call newline

    ret
print_u2 endp
CSEG ENDS


END
