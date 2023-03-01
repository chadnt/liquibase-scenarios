create or replace package body will_call_proc1_tests
as
    procedure test_will_call_proc1
    is
    begin
        caller_package.will_call_proc1();
    end test_will_call_proc1;
end will_call_proc1_tests;