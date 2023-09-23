Feature: IO library test - fn_io_mount_host_slot

  This tests FN-IO fn_io_mount_host_slot

  Scenario Outline: execute _fn_io_mount_host_slot
    Given atari-fn-io application test setup
      And I add common atari-io files
      And I add atari src file "fn_io_mount_host_slot.s"
      And I add file for compiling "features/atari/test-apps/test_void_b.s"
      And I add file for compiling "features/atari/stubs/bus-simple.s"
      And I create and load application
      And I write memory at $80 with $00
      And I write memory at t_b1 with <slot>
      And I write word at t_fn with address _fn_io_mount_host_slot
     When I execute the procedure at _init for no more than 70 instructions

    # check the DCB values were set correctly
    Then I expect to see DDEVIC equal $70
     And I expect to see DUNIT equal $01
     And I expect to see DTIMLO equal $0f
     And I expect to see DCOMND equal $f9
     # rare to see 00 in DSTATS
     And I expect to see DSTATS equal $00
     And I expect to see DBYTLO equal $00
     And I expect to see DBYTHI equal $00
     And I expect to see DAUX1 equal <slot>
     And I expect to see DAUX2 equal $00
     And I expect to see DBUFLO equal $00
     And I expect to see DBUFHI equal $00

     # verify BUS was called
     And I expect to see $80 equal 1

    Examples:
    | slot |
    | 0    |
    | 1    |
    | 2    |
