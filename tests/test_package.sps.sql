create or replace package test_package
as
    -- %suite(Scenario tests)
    
    -- %test(Test will_call_proc1)
    procedure test_will_call_proc1;

    -- %test(Test references_column_type)
    procedure test_references_column_type;

end test_package;