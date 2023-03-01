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

    procedure test_demo_table_not_empty
    is
        l_count integer;
    begin
        execute immediate 'select count(*) from demo_table' into l_count;
        ut.expect(l_count).to_be_greater_than(0);
    end test_demo_table_not_empty;

end test_package;