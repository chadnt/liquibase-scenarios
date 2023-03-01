create or replace package body referenced_package
as
    procedure proc1
    is
    begin
        dbms_output.put_line('In referenced_package.proc1');
    end proc1;
end referenced_package;