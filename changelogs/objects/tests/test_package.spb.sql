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

    procedure test_add_column
    is
    begin
        caller_package.add_column('foo');
        execute immediate 'alter table demo_table drop column foo';
    end test_add_column;

end test_package;