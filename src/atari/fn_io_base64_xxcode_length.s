        .export         _fn_io_base64_decode_length
        .export         _fn_io_base64_encode_length

        .import         fn_io_copy_cmd_data
        .import         _fn_io_do_bus
        .import         _fn_io_error
        .import         popa, popax

        .include        "fn_zp.inc"
        .include        "fn_macros.inc"
        .include        "fn_data.inc"

; uint8_t fn_io_base64_decode_length(unsigned long *len);
;
_fn_io_base64_decode_length:
        axinto   tmp7                   ; pointer to len in tmp7/8
        setax   #t_fn_io_base64_decode_length

de_common:
        jsr     fn_io_copy_cmd_data

        mwa     tmp7, IO_DCB::dbuflo
        mva     #$03, IO_DCB::dtimlo
        jsr     _fn_io_do_bus
        jmp     _fn_io_error

; uint8_t fn_io_base64_encode_length(unsigned long *len);
;
_fn_io_base64_encode_length:
        axinto  tmp7                   ; pointer to len in tmp7/8
        setax   #t_fn_io_base64_encode_length
        jmp     de_common

.rodata
t_fn_io_base64_decode_length:
        .byte $ca, $40, 4, 0, 0, 0

t_fn_io_base64_encode_length:
        .byte $ce, $40, 4, 0, 0, 0
