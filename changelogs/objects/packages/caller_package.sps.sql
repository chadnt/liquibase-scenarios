create or replace package caller_package
as
    procedure will_call_proc1;

    procedure references_column_type(
        v_description in demo_table.description%type);

    procedure add_column(
        v_name in varchar2);

    procedure remove_column(
        v_name in varchar2);

end caller_package;