        .export         _fn_io_put_device_slots

        .import         _fn_io_copy_cmd_data, _fn_io_do_bus

        .include        "zeropage.inc"
        .include        "fn_macros.inc"
        .include        "fn_data.inc"
        .include        "fn_io.inc"

; void _fn_io_put_device_slots(DeviceSlot *device_slots)
.proc _fn_io_put_device_slots
        axinto  ptr1

        setax   #t_io_put_device_slots
        jsr     _fn_io_copy_cmd_data

        mwa     ptr1, IO_DCB::dbuflo
        jmp     _fn_io_do_bus
.endproc

.rodata
.define DS8zL .lobyte(.sizeof(DeviceSlot)*8)
.define DS8zH .hibyte(.sizeof(DeviceSlot)*8)

t_io_put_device_slots:
        .byte $f1, $80, DS8zL, DS8zH, $00, $00
