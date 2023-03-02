create or replace package test_package
as
    -- %suite(Scenario tests)
    -- %rollback(manual)
    
    -- %test(Test will_call_proc1)
    procedure test_will_call_proc1;

    -- %test(Test references_column_type)
    procedure test_references_column_type;

    -- %test(Test add_column)
    procedure test_add_column;

end test_package;