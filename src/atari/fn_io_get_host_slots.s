        .export         _fn_io_get_host_slots
        .import         _fn_io_copy_cmd_data, _fn_io_do_bus

        .include        "zeropage.inc"
        .include        "fn_macros.inc"
        .include        "fn_io.inc"
        .include        "fn_data.inc"

; void _fn_io_get_host_slots(struct HostSlot *)
.proc _fn_io_get_host_slots
        axinto  ptr1
        setax   #t_io_get_host_slots
        jsr     _fn_io_copy_cmd_data

        mwa     ptr1, IO_DCB::dbuflo
        jmp     _fn_io_do_bus
.endproc

.rodata
.define HS8zL .lobyte(.sizeof(HostSlot)*8)
.define HS8zH .hibyte(.sizeof(HostSlot)*8)

t_io_get_host_slots:
        .byte $f4, $40, $ff, $ff, HS8zL, HS8zH, $00, $00