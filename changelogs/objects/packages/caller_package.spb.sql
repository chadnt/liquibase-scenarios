create or replace package body caller_package
as
    procedure will_call_proc1
    is
    begin
        dbms_output.put_line('In will_call_proc1...');
        dbms_output.put_line('   will_call_proc1: calling referenced_package.proc1');
        referenced_package.proc1();
    end will_call_proc1;

    procedure references_column_type (
        v_description in demo_table.description%type)
    is
    begin
        dbms_output.put_line(v_description);
    end references_column_type;

    procedure add_column(
        v_name in varchar2)
    is
    begin
        execute immediate 'alter table demo_table add ' || v_name || ' varchar2(10)';
    end add_column;

    procedure remove_column(
        v_name in varchar2)
    is
    begin
        execute immediate 'alter table demo_table drop column ' || v_name;
    end remove_column;
    
end caller_package;