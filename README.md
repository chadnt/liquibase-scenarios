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
3. a migration script attempts to populate the field with the wrong data type
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
To-do

### Scenario 4: bad aparameter
To-do