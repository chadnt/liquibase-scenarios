#! /bin/sh

scenario=${1-0}

if [ $scenario -eq 1 ]
then
    message='Scenario 1: a packaged procedure references a missing procedure. Tests fail.'
    changelog=changelog_missing_procedure.yaml
elif [ $scenario -eq 2 ]
then
    message='Scenario 2: a packaged procedure references a missing column. Tests fail.'
    changelog=changelog_missing_column.yaml
elif [ $scenario -eq 3 ]
then
    message='Scenario 3: attempt to insert wrong data type. Deploy fails.'
    changelog=changelog_insert_wrong_datatype.yaml
elif [ $scenario -eq 4 ]
then
    message='Scenario 4: attempt to add an existing column using packaged procedure. Deploy fails.'
    changelog=changelog_add_existing_column.yaml
else
    message='Default scenario: all tests should pass.'
    changelog=changelog.yaml
fi

echo ${message}
echo
echo 'Deploying...'
if liquibase --changelog-file=changelogs/${changelog} --showbanner=false update
then
    echo
    echo 'Testing...'
    ./test.sh
fi
echo
echo 'Rolling back changes...'
liquibase --changelog-file=changelogs/${changelog} rollback-count 999 &> /dev/null
echo 'Done.'