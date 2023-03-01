#! /bin/sh

scenario=${1-0}

if [ $scenario -eq 1 ]
then
    message='Scenario 1: a packaged procedure references a missing procedure. Tests should fail.'
    changelog=changelog_missing_procedure.yaml
elif [ $scenario -eq 2 ]
then
    message='Scenario 2: a packaged procedure references a missing column. Tests should fail.'
    changelog=changelog_missing_column.yaml
elif [ $scenario -eq 3 ]
then
    message='Scenario 3: attempt to insert wrong data type. Tests should fail.'
    changelog=changelog_insert_wrong_datatype.yaml
else
    message='Default scenario: all tests should pass.'
    changelog=changelog.yaml
fi

echo ${message}
echo
echo 'Deploying...'
liquibase --changelog-file=changelogs/${changelog} --showbanner=false update
echo
echo 'Testing...'
./test.sh
echo
echo 'Rolling back changes...'
liquibase --changelog-file=changelogs/${changelog} rollback-count 999 &> /dev/null
echo 'Done.'