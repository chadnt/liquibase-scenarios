#! /bin/sh

if [ "$1" == "bad" ]
then
    message='Dependencies are intentionally missing. Tests should fail.'
    changelog=changelog_bad.yaml
else
    message='Tests should pass.'
    changelog=changelog.yaml
fi

echo 'Deploy and test a packaged procedure which calls another procedure.'
echo ${message}
echo
echo 'Deploying...'
liquibase --changelog-file=${changelog} --showbanner=false update
echo
echo 'Testing...'
./test.sh
echo
echo 'Rolling back changes...'
liquibase --changelog-file=${changelog} rollback-count 6 &> /dev/null
echo 'Done.'