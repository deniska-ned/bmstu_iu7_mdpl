SSEG SEGMENT STACK 'STACK'
    db 100h dup ('s')
SSEG ENDS

DSEG SEGMENT 'DATA'
    mes_input_row_count db  "Input matrix row count: ", "$"
    mes_input_col_count db  "Input matrix col count: ", "$"
    mes_input_matrix    db  "Input matrix:", 0Dh, 0Ah, "$"
    mes_res_matrix      db  "Result matrix:", 0Dh, 0Ah, "$"

    matrix_row_count    db  2
    matrix_col_count    db  3
    matrix              db  81 dup (0)
DSEG ENDS


CSEG SEGMENT 'CODE'
    assume SS:SSEG, DS:DSEG, CS:CSEG

endl:
    mov ah, 02h
    mov dl, 0Dh
    int 21h
    mov dl, 0Ah
    int 21h

    ret

matrix_input_row_count:
    mov dx, offset mes_input_row_count
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h
    sub al, '0'
    mov matrix_row_count, al
    
    call endl

    ret


matrix_input_col_count:
    mov dx, offset mes_input_col_count
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h
    sub al, '0'
    mov matrix_col_count, al
    
    call endl

    ret

matrix_input:
    mov dx, offset mes_input_matrix
    mov ah, 09h
    int 21h

    xor bx, bx
    xor si, si
    xor cx, cx
    
    mov cl, matrix_row_count
input_row_loop:
    mov es, cx

    mov cl, matrix_col_count
    xor si, si
input_col_loop:
    mov ah, 01h
    int 21h
    sub al, '0'
    mov matrix[bx][si], al

    inc si

    loop input_col_loop

    call endl
    add bx, 09h
    mov cx, es

    loop input_row_loop
    
    ret

matrix_proc:
    xor cx, cx

    mov bx, 0009h
    
    mov cl, matrix_row_count
    shr cl, 1
    cmp cl, 0
    je proc_end
proc_row_loop:
    mov es, cx

    mov cl, matrix_col_count
    xor si, si
proc_col_loop:
    sub bx, 9
    mov al, matrix[bx][si]
    add bx, 18
    add al, matrix[bx][si]
    sub bx, 9

    cmp al, 9
    jbe proc_le_9_loop
    sub al, 10
proc_le_9_loop:
    mov matrix[bx][si], al
    inc si

    loop proc_col_loop

    call endl
    add bx, 18
    mov cx, es

    loop proc_row_loop
    
proc_end:
    ret

matrix_print:
    mov dx, offset mes_res_matrix
    mov ah, 09h
    int 21h

    xor bx, bx
    xor si, si
    xor cx, cx
    
    mov cl, matrix_row_count
print_row_loop:
    mov es, cx

    mov cl, matrix_col_count
    xor si, si
print_col_loop:
    mov dl, matrix[bx][si]
    add dl, '0'
    mov ah, 02h
    int 21h

    inc si

    loop print_col_loop

    call endl
    add bx, 09h
    mov cx, es

    loop print_row_loop
    
    ret

main:
    mov ax, DSEG
    mov ds, ax

    call matrix_input_row_count
    call matrix_input_col_count
    call matrix_input
    call matrix_proc
    call matrix_print

    mov ah, 4Ch
    int 21h
CSEG ENDS

END main
