# liquibase-scenarios
Repository to share simple sample scenarios to demostrate Liquibase Enterprise forecast capability.

## Setup
These scripted scenarios depend on `liquibase` and `utplsql-cli`. Shell script `deploy_and_test.sh` installs changes for each scenario, runs tests, and rolls all changes back. Pass the scenario number as an argument to the script to demonstrate that scenario.

## Scenarios
Can the liquibase Enterprise forecast feature detect and report when:

- a packaged procedure references a missing procedure
- a packaged procedure references a missing column
- a migration script attempts to populate the field with the wrong data type
- a migration script calls a packaged procedure with an invalid parameter

### Default scenario: all green
- Procedure `caller_package.will_call_proc1` calls `referenced_package.proc1`.
- The default changelog `changelog.yaml` installs all objects.
- All tests pass.

```
$> ./deploy_and_test.sh
Default scenario: all tests should pass.

Deploying...
[...]
Liquibase command 'update' was executed successfully.

Testing...
[...]
1 tests, 0 failed, 0 errored, 0 disabled, 0 warning(s)
```

### Scenario 1: procedure reference a missing procedure
- The changelog `changelog_missing_procedure.yaml` does not install `referenced_package`.
- Tests for `caller_package.will_call_proc1` fail on error due to the missing reference.

```
$> ./deploy_and_test.sh 1
Scenario 1: a packaged procedure references a missing procedure. Tests should fail.

Deploying...
[...]
Liquibase command 'update' was executed successfully.

Testing...
13:19:23.648 [main] DEBUG org.utplsql.cli.Cli - Args: run, -cq, liquibase/liquibase@localhost/xepdb1
will_call_proc1 tests
  Test will_call_proc1 [.124 sec] (FAILED - 1)
 
Failures:
 
  1) test_will_call_proc1
      ORA-04063: package body "LIQUIBASE.CALLER_PACKAGE" has errors
      ORA-06508: PL/SQL: could not find program unit being called: "LIQUIBASE.CALLER_PACKAGE"
      ORA-06512: at "LIQUIBASE.WILL_CALL_PROC1_TESTS", line 6
      ORA-06512: at "LIQUIBASE.WILL_CALL_PROC1_TESTS", line 6
      ORA-06512: at line 6
Finished in .146541 seconds
1 tests, 0 failed, 1 errored, 0 disabled, 0 warning(s)
```

### Scenario 2: procedure references a missing column
