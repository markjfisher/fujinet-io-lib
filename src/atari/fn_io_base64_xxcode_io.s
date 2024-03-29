        .export         _fn_io_base64_decode_input
        .export         _fn_io_base64_decode_output
        .export         _fn_io_base64_encode_input
        .export         _fn_io_base64_encode_output

        .import         _fn_io_do_bus
        .import         fn_io_copy_cmd_data
        .import         io_common
        .import         popa, popax

        .include        "fn_zp.inc"
        .include        "fn_macros.inc"
        .include        "fn_data.inc"

; uint8_t fn_io_base64_decode_input(char *s, uint16_t len);
;
_fn_io_base64_decode_input:
        axinto  tmp7                    ; len in tmp7/8
        setax   #t_fn_io_base64_decode_input
        jmp     io_common

; uint8_t fn_io_base64_decode_output(char *s, uint16_t len);
;
_fn_io_base64_decode_output:
        axinto  tmp7                    ; len in tmp7/8
        setax   #t_fn_io_base64_decode_output
        jmp     io_common

; uint8_t fn_io_base64_encode_input(char *s, uint16_t len);
;
_fn_io_base64_encode_input:
        axinto  tmp7                    ; len in tmp7/8
        setax   #t_fn_io_base64_encode_input
        jmp     io_common

; uint8_t fn_io_base64_encode_output(char *s, uint16_t len);
;
_fn_io_base64_encode_output:
        axinto  tmp7                    ; len in tmp7/8
        setax   #t_fn_io_base64_encode_output
        jmp     io_common


.rodata
t_fn_io_base64_decode_input:
        .byte $cc, $80, $ff, $ff, $ff, $ff

t_fn_io_base64_decode_output:
        .byte $c9, $40, $ff, $ff, $ff, $ff

t_fn_io_base64_encode_input:
        .byte $d0, $80, $ff, $ff, $ff, $ff

t_fn_io_base64_encode_output:
        .byte $cd, $40, $ff, $ff, $ff, $ff

