create or replace package body caller_package
as
    procedure will_call_proc1
    is
    begin
        dbms_output.put_line('In will_call_proc1...');
        dbms_output.put_line('   will_call_proc1: calling referenced_package.proc1');
        referenced_package.proc1();
    end will_call_proc1;
end caller_package;