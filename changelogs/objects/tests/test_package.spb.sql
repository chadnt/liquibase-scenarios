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

    procedure test_add_column
    is
    begin
        caller_package.add_column('foo');
        execute immediate 'alter table demo_table drop column foo';
    end test_add_column;

    procedure test_remove_column
    is
    begin
        execute immediate 'alter table demo_table add foo varchar2(10)';
        caller_package.remove_column('foo');
    end test_remove_column;

end test_package;