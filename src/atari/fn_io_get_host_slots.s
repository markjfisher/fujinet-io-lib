        .export         _fn_io_get_host_slots
        .import         fn_io_copy_cmd_data, _fn_io_do_bus

        .include        "fn_zp.inc"
        .include        "fn_macros.inc"
        .include        "fn_io.inc"
        .include        "fn_data.inc"

; void fn_io_get_host_slots(struct HostSlot *host_slots)
.proc _fn_io_get_host_slots
        axinto  tmp7
        setax   #t_io_get_host_slots
        jsr     fn_io_copy_cmd_data

        mwa     tmp7, IO_DCB::dbuflo
        jmp     _fn_io_do_bus
.endproc

.rodata
.define HS8zL .lobyte(.sizeof(HostSlot)*8)
.define HS8zH .hibyte(.sizeof(HostSlot)*8)

t_io_get_host_slots:
        .byte $f4, $40, HS8zL, HS8zH, $00, $00
