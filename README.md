# liquibase-scenarios
Repository to share simple sample scenarios to demostrate Liquibase Enterprise forecast capability.

## Setup
These scripted scenarios depend on `liquibase` and `utplsql-cli`. Shell script `deploy_and_test.sh` installs changes for each scenario, runs tests, and rolls all changes back. Pass the scenario number as an argument to the script to demonstrate that scenario.

``` sh
# default scenario: all tests pass
deploy_and_test.sh

# to demonstrate scenario 1
deploy_and_test.sh 1
```

## Scenarios
Can the Liquibase Enterprise forecast feature detect and report when:

1. a packaged procedure references a missing procedure
2. a packaged procedure references a missing column
3. a migration script attempts to populate a field with the wrong data type
4. a migration script calls a packaged procedure with an invalid parameter

### Default scenario: all test pass
- The default changelog `changelog.yaml` installs all objects.
- All tests pass.

Example output
```
$> ./deploy_and_test.sh
Default scenario: all tests should pass.

Deploying...
[...]
Liquibase command 'update' was executed successfully.

Testing...
[...]
2 tests, 0 failed, 0 errored, 0 disabled, 0 warning(s)
```

### Scenario 1: procedure reference a missing procedure
- The changelog `changelog_missing_procedure.yaml` does not install `referenced_package`.
- Procedure `caller_package.will_call_proc1` attempts to reference `referenced_package.proc1`.
- Tests fail on error due to the missing reference.

### Scenario 2: procedure references a missing column
- The changelog `changelog_missing_column.yaml` does not include the column `demo_table.description`.
- Procedure `caller_package.references_column_type` attempts to reference the missing column.
- Tests fail on error due to the missing reference.

### Scenario 3: wrong data type
- The changelog `changelog_insert_wrong_datatype.yaml` attempts to insert `'one'` into numeric column `demo_table.id`.
- Insert fails due invalid number (ORA-017222)
- Test verifying `demo_table` contains data fails.

### Scenario 4: bad parameter
To-do
This scenario is intended to simulate how PSI uses procedures for DDL.
Create new procedures to add and remove columns from demo_table.
Default scenario will add foo and remove foo.
Bad scenario will try to remove foo without adding it.
My guess is forecaster will not be able to detect this kind of "runtime" error in advance.
Would be impressive if it can.

## De-duplicate
This is just a toy project, but the duplication in the changelogs is getting a bit unwieldy, already.
Take a moment and focus minimizing duplication before proceeding to scenario 4.
Nothing too fancy, just make it easier to read and scale.