        .export         fn_io_copy_cmd_data

        .include        "fn_zp.inc"
        .include        "fn_macros.inc"
        .include        "fn_data.inc"

; INTERNAL COPY ROUTINE
; void fn_io_copy_cmd_data(void *cmd_table)
;
; Sets DCB data from given table address
; Trashes tmp9/10 as only ZP location
.proc fn_io_copy_cmd_data
        ; the table of dcb bytes to insert
        axinto  tmp9

        ; first 2 bytes always $70, $01, so we can do those manually. saves table space, and loops
        mva     #$70, IO_DCB::ddevic
        mva     #$01, IO_DCB::dunit

        ; these 2 are always set by the command, no use having them in the table
        mva     #$00, IO_DCB::dbuflo
        sta     IO_DCB::dbufhi

        ; almost all devices use $0f
        mva     #$0f, IO_DCB::dtimlo

        ; copy bytes of table into DCB
        ldy     #5      ; 6 bytes to copy
l1:
        ldx     dcb_offsets, y
        mva     {(tmp9), y}, {IO_DCB::ddevic, x}
        dey
        bpl     l1

        rts
.endproc

.rodata
; which DCB entries to write to, indexed from DDEVIC
; DCOMND, DSTATS, DBYTLO, DBYTHI, DAUX1, DAUX2
dcb_offsets: .byte 2, 3, 8, 9, 10, 11
