create or replace package body test_package
as

    procedure test_will_call_proc1
    is
    begin
        caller_package.will_call_proc1();
    end test_will_call_proc1;

    procedure test_references_column_type
    is
    begin
        caller_package.references_column_type('this is a description');
    end test_references_column_type;

end test_package;