bits 64

[list -]
    %define TRUE    1
    %define FALSE   0
    %define NULL    0

    extern  gtk_init
    extern  gtk_window_new
    extern  gtk_window_set_title
    extern  gtk_window_set_default_size
    extern  gtk_container_set_border_width
    extern  gtk_button_new_with_label

    extern  gtk_spin_button_new_with_range
    extern  gtk_spin_button_set_digits
    extern  gtk_spin_button_get_value_as_int

    extern  gtk_label_new
    extern  gtk_label_set_text

    extern  gtk_box_new
    extern  gtk_widget_set_tooltip_text

    extern  gtk_container_add
    extern  gtk_widget_show_all
    extern  gtk_main_quit
    extern  g_signal_connect_data
    extern  gtk_main
    extern  exit

    extern  g_strdup_printf
    extern  g_free
[list +]

section .rodata
    window_title:   db  "Digit adder", 0
    szDestroy:      db  "destroy", 0
    szTooltip:      db  "Button Widget",0

    szIntMask       db  "%d", 0

section .data
    window:         dq  0
    vbox:           dq  0
    spinbox_1:      dq  0
    spinbox_2:      dq  0
    button:
     .handle:       dq  0
     .label:        db  "Add",  0

    signal:
     .clicked: db   "clicked",  0
    res_label:
     .handle        dq  0
     .default:      dq  "0",    0

    str:            dq  0
section .text

global _start

on_button_add_clicked:
    push    rsi

    mov     rdi,    qword[spinbox_1]
    call    gtk_spin_button_get_value_as_int
    mov     r10,    rax


    mov     rdi,    qword[spinbox_2]
    call    gtk_spin_button_get_value_as_int
    mov     rsi,    r10
    add     rsi,    rax

    mov     rdi,    szIntMask
    call    g_strdup_printf
    mov     [str],  rax

    mov     rdi,    qword[res_label.handle]
    mov     rsi,    [str]
    call    gtk_label_set_text

    mov     rdi,    [str]
    call    g_free
    mov     qword[str], 0

    pop  rsi
    ret

_start:

    ;init gtk
    xor     rsi,    rsi                         ;argv
    xor     rdi,    rdi                         ;argc
    call    gtk_init

    ;the main window
    xor     rdi,    rdi                         ;GTK_WINDOW_TOPLEVEL
    call    gtk_window_new
    mov     qword[window],  rax

    ;set title
    mov     rdi,    qword[window]
    mov     rsi,    window_title
    call    gtk_window_set_title

    ;set size
    mov     rdi,    qword[window]
    mov     rsi,    300                         ;width
    mov     rdx,    150                         ;height
    call    gtk_window_set_default_size

    ;set border width
    mov     rdi,    qword[window]
    mov     rsi,    15                          ;borderwidth
    call    gtk_container_set_border_width

    ;add vbox container
    mov     rdi,    TRUE
    mov     rsi,    1
    call    gtk_box_new
    mov     qword[vbox],    rax

    ;add the spinbox_1 to the vbox container
    mov     rdi,    __?float64?__(0.0)
    movq    XMM0,   rdi
    mov     rsi,    __?float64?__(9.0)
    movq    XMM1,   rsi
    mov     rdx,    __?float64?__(1.0)
    movq    XMM2,   rdx
    call    gtk_spin_button_new_with_range
    mov     qword[spinbox_1],   rax

    mov     rdi,    rax
    mov     rsi,    0
    call    gtk_spin_button_set_digits

    mov     rdi,    qword[vbox]
    mov     rsi,    qword[spinbox_1]
    call    gtk_container_add

    ;add the spinbox_2 to the vbox container
    mov     rdi,    __?float64?__(0.0)
    movq    XMM0,   rdi
    mov     rsi,    __?float64?__(9.0)
    movq    XMM1,   rsi
    mov     rdx,    __?float64?__(1.0)
    movq    XMM2,   rdx
    call    gtk_spin_button_new_with_range
    mov     qword[spinbox_2],   rax

    mov     rdi,    rax
    mov     rsi,    0
    call    gtk_spin_button_set_digits

    mov     rdi,    qword[vbox]
    mov     rsi,    qword[spinbox_2]
    call    gtk_container_add

    ;add the button to the vbox container
    mov     rdi,    button.label
    call    gtk_button_new_with_label
    mov     qword[button],  rax

    mov     rdi,    qword[button]
    mov     rsi,    szTooltip
    call    gtk_widget_set_tooltip_text

    mov     rdi,    qword[vbox]
    mov     rsi,    qword[button]
    call    gtk_container_add

    ;add the label to the vbox container
    call    gtk_label_new
    mov     qword[res_label.handle],    rax

    mov     rdi,    qword[res_label.handle]
    mov     rsi,    res_label.default
    call    gtk_label_set_text

    mov     rdi,    qword[vbox]
    mov     rsi,    qword[res_label.handle]
    call    gtk_container_add

    ;add the vbox container to the window
    mov     rdi,    qword[window]
    mov     rsi,    qword[vbox]
    call    gtk_container_add

    ;signal for button
    xor     r9d,    r9d
    xor     r8d,    r8d
    mov     rcx,    NULL
    mov     rdx,    on_button_add_clicked
    mov     rsi,    signal.clicked
    mov     rdi,    qword[button.handle]
    call    g_signal_connect_data

    ;show window
    mov     rdi,    qword[window]
    call    gtk_widget_show_all

    ;connect destroy signal to the window
    xor     r9d,    r9d                     ;combination of GConnectFlags
    xor     r8d,    r8d                     ;a GClosureNotify for data
    mov     rcx,    qword[window]           ;pointer to window instance in RCX
    mov     rdx,    gtk_main_quit           ;pointer to the handler
    mov     rsi,    szDestroy               ;pointer to the signal
    mov     rdi,    qword[window]           ;pointer to window instance in RDI
    call    g_signal_connect_data           ;the value in RAX is the handler,
                                            ;   but we don't store it now

    ;go into application main loop
    call    gtk_main

    ;exit program
    xor     rdi,    rdi
    call    exit
