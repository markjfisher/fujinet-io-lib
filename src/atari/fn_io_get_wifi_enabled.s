        .export         _fn_io_get_wifi_enabled
        .import         _fn_io_bus
        .import         return0, return1

        .include        "zeropage.inc"
        .include        "fn_macros.inc"

; int fn_io_get_wifi_enabled()
;
; sets A=1 if wifi is enabled. 0 otherwise, X=0 in both cases for calling convention
.proc _fn_io_get_wifi_enabled
        setax   #t_io_get_wifi_enabled
        jsr     _fn_io_bus

        ; was it set?
        lda     tmp4
        cmp     #$01
        bne     :+

        ; yes
        jmp     return1

        ; no
:       jmp     return0

.endproc

.rodata
t_io_get_wifi_enabled:
        .byte $ea, $40, <tmp4, >tmp4, $01, $00, $00, $00