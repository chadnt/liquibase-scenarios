create or replace package test_package
as
    -- %suite(Scenario tests)
    
    -- %test(Test will_call_proc1)
    procedure test_will_call_proc1;

    -- %test(Test references_column_type)
    procedure test_references_column_type;

    -- %test(demo_table should not be empty)
    procedure test_demo_table_not_empty;

end test_package;