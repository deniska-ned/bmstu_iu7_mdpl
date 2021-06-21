.186


PUBLIC print_s8


EXTRN number        :   word

EXTRN newline       :   near


DSEG SEGMENT PUBLIC 'DATA'
    bin_mask_cpy    dw  8000h
    oct_mask        dw  57344 ;E000h
    oct_prefix      db  "0o$"
DSEG ENDS


CSEG SEGMENT PUBLIC 'CODE'
assume ds:dseg

print_s8 proc near
    mov bx, number

    cmp bx, 0h

    jge skip_neg

    neg bx

    mov dl, '-'
    mov ah, 02h
    int 21h
skip_neg:

    mov dx, offset oct_prefix
    mov ah, 09h
    int 21h

    mov dx, bin_mask_cpy
    and dx, bx
    
    shr dx, 0Fh

    add dl, '0'
    mov ah, 02h
    int 21h

    shl bx, 1

    mov cx, 5h
print_u8_digit:
    mov dx, oct_mask
    and dx, bx

    shr dx, 0Dh

    add dl, '0'
    mov ah, 02h
    int 21h

    shl bx, 3
    loop print_u8_digit

    call newline

    ret
print_s8 endp
CSEG ENDS


END
