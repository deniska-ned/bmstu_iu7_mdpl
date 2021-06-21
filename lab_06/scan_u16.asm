.186


PUBLIC scan_u16


EXTRN number    :   word

EXTRN newline   :   near


DSEG SEGMENT PUBLIC 'DATA'
    buffersize  db  5h
    inputlen    db  0
    buffer      db  6h DUP('b')
DSEG ENDS


CSEG SEGMENT PUBLIC 'CODE'
    assume DS:DSEG
scan_u16 proc near
    mov dx, OFFSET buffersize
    mov ah, 0Ah
    int 21h

    call newline

    xor ax, ax ; mul res

    mov si, 0  ; array index
    xor dx, dx ; num digit
    xor cx, cx
    mov cl, inputlen
str_to_num:
    shl ax, 4

    mov dl, buffer[si]

    cmp dl, 'a'
    jae symbols_af
    cmp dl, 'A'
    jae symbols_af_big
    cmp dl, '0'
    jae symbols_09

symbols_af:
    sub dl, 'a'
    add dl, 0Ah
    jmp symbols_out
symbols_af_big:
    sub dl, 'A'
    add dl, 0Ah
    jmp symbols_out
symbols_09:
    sub dl, '0'
    jmp symbols_out
symbols_out:


    add ax, dx
    
    inc si
    loop str_to_num

    mov number, ax
    
    ret
scan_u16 endp
CSEG ENDS


END
