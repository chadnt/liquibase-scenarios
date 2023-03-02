#! /bin/sh

scenario=${1-0}

pick_scenario()
{
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
}

deploy()
{
    echo
    echo 'Deploying...'
    liquibase --changelog-file=changelogs/${changelog} --showbanner=false update
}

run_tests()
{
    echo
    echo 'Testing...'
    ./test.sh
}

notify_deploy_failed()
{
    red='\033[0;31m'
    colorless='\033[0m'
    echo
    echo ${red}Deploy failed.${colorless}
}

rollback()
{
    echo
    echo 'Rolling back changes...'
    liquibase --changelog-file=changelogs/${changelog} rollback-count 999 &> /dev/null
    echo 'Done.'
}

pick_scenario

if deploy
then
    run_tests
else
    notify_deploy_failed
fi

rollback