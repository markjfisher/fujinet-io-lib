        .export         _fn_io_set_device_filename
        .import         fn_io_copy_cmd_data, _fn_io_do_bus
        .import         popa

        .include        "fn_zp.inc"
        .include        "fn_macros.inc"
        .include        "fn_data.inc"


; void _fn_io_set_device_filename(uint8_t mode, uint8_t hs, uint8_t ds, char *buffer)
.proc _fn_io_set_device_filename
        axinto  tmp7    ; buffer

        setax   #t_io_set_device_filename
        jsr     fn_io_copy_cmd_data

        jsr     popa            ; device slot
        sta     IO_DCB::daux1

        jsr     popa    ; host slot
        beq     :+
        asl     a
        asl     a
        asl     a
        asl     a       ; * 16

:       sta     tmp10

        ; setup aux2 = host_slot * 16 + mode
        jsr     popa    ; mode
        adw1    tmp10, a
        sta     IO_DCB::daux2

        mwa     tmp7, IO_DCB::dbuflo
        jmp     _fn_io_do_bus
.endproc

.rodata
t_io_set_device_filename:
        .byte $e2, $80, $00, $01, $ff, $00
