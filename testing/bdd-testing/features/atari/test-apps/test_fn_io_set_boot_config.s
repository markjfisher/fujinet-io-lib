        .import         _fn_io_set_boot_config
        .export         _main, t_toggle
        .include        "fn_macros.inc"

.proc _main
        lda     t_toggle

        jsr     _fn_io_set_boot_config
        rts
.endproc

.bss
t_toggle:   .res 1