Feature: IO library test - fn_io_set_boot_mode

  This tests FN-IO fn_io_set_boot_mode

  Scenario: execute _fn_io_set_boot_mode
    Given atari-fn-io application test setup
      And I add common atari-io files
      And I add atari src file "fn_io_set_boot_mode.s"
      And I add file for compiling "features/atari/test-apps/test_b.s"
      And I add file for compiling "features/atari/stubs/bus-simple.s"
      And I create and load atari application
      And I write memory at $80 with $ff
      And I write memory at t_b1 with $0b
      And I write word at t_fn with address _fn_io_set_boot_mode
     When I execute the procedure at _init for no more than 70 instructions

    # check the DCB values were set correctly
    Then I expect to see DDEVIC equal $70
     And I expect to see DUNIT equal $01
     And I expect to see DTIMLO equal $0f
     And I expect to see DCOMND equal $d6
     And I expect to see DSTATS equal $00
     And I expect to see DBYTLO equal $00
     And I expect to see DBYTHI equal $00
     And I expect to see DAUX1 equal $0b
     And I expect to see DAUX2 equal $00
     And I expect to see DBUFLO equal $00
     And I expect to see DBUFHI equal $00

    # check BUS was called
    Then I expect to see $80 equal $01
