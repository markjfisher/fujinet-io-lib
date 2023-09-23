Feature: IO library test - fn_io_set_device_filename

  This tests FN-IO fn_io_set_device_filename

  Scenario Outline: execute _fn_io_set_device_filename
    Given atari-fn-io application test setup
      And I add common atari-io files
      And I add atari src file "fn_io_set_device_filename.s"
      And I add file for compiling "features/atari/test-apps/test_bbbw.s"
      And I add file for compiling "features/atari/stubs/bus-simple.s"
      And I create and load application
      And I write memory at $80 with $00
      And I write memory at t_b1 with <mode>
      And I write memory at t_b2 with <host_slot>
      And I write memory at t_b3 with <device_slot>
      And I write word at t_w4 with hex a000
      And I write word at t_fn with address _fn_io_set_device_filename

     When I execute the procedure at _init for no more than 130 instructions

    # check the DCB values were set correctly
    Then I expect to see DDEVIC equal $70
     And I expect to see DUNIT equal $01
     And I expect to see DTIMLO equal $0f
     And I expect to see DCOMND equal $e2
     And I expect to see DSTATS equal $80
     And I expect to see DBYTLO equal $00
     And I expect to see DBYTHI equal $01
     And I expect to see DAUX1 equal <device_slot>
     And I expect to see DAUX2 equal <hs_x_16_plus_mode>
     And I expect to see DBUFLO equal lo($a000)
     And I expect to see DBUFHI equal hi($a000)

     # verify BUS was called
     And I expect to see $80 equal 1
  Examples:
  | device_slot | host_slot  | mode | hs_x_16_plus_mode |
  | $01         | $01        | $02  | $12               |
  | $02         | $03        | $04  | $34               |
