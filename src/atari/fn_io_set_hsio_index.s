        .export         _fn_io_set_hsio_index

        .import         fn_io_copy_cmd_data
        .import         _fn_io_do_bus
        .import         popa, popax

        .include        "fn_zp.inc"
        .include        "fn_macros.inc"
        .include        "fn_data.inc"

; void fn_io_set_hsio_index(bool save, uint8_t index);
;
.proc _fn_io_set_hsio_index
        sta     tmp7                    ; HSIO index to set
        setax   #t_fn_io_set_hsio_index
        jsr     fn_io_copy_cmd_data

        mva     tmp7, IO_DCB::daux1
        jsr     popa                    ; should we save? 0 = no, 1 = yes
        sta     IO_DCB::daux2

        jmp     _fn_io_do_bus
.endproc

.rodata
t_fn_io_set_hsio_index:
        .byte $e3, 0, 0, 0, $ff, $ff
