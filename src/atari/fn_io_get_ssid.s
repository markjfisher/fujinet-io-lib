        .export         _fn_io_get_ssid
        .import         fn_io_copy_cmd_data, _fn_io_do_bus

        .include        "fn_zp.inc"
        .include        "fn_macros.inc"
        .include        "fn_io.inc"
        .include        "fn_data.inc"

; void _fn_io_get_ssid(NetConfig *net_config)
;
; read ssid to fn_io_net_config
.proc _fn_io_get_ssid
        axinto  tmp7

        setax   #t_io_get_ssid
        jsr     fn_io_copy_cmd_data

        ; copy mem location to DCB, and call bus
        mwa     tmp7, IO_DCB::dbuflo
        jmp     _fn_io_do_bus
.endproc

.rodata
.define NCsz .sizeof(NetConfig)

t_io_get_ssid:
        .byte $fe, $40, <NCsz, >NCsz, $00, $00
