#!/bin/bash

jira_issue=$1

issue_info=$(curl -s "https://synaos.atlassian.net/rest/api/2/issue/$1?fields=summary,issuetype" --user francisco.roa.prieto@synaos.com:"$JIRA_API_KEY")

issue_summary=$(echo "$issue_info" | jq .fields.summary -r)
issue_summary="$(cut -d '|' -f2 <<<"$issue_summary")"
issue_summary="${issue_summary// /_}"

issue_prefix=$(echo "$issue_info" | jq .fields.issuetype.name -r | tr '[:upper:]' '[:lower:]')

git fetch origin
git branch --all | grep "$jira_issue"

echo "$PWD"
# :call vira#_refresh()
# if [ $? = 0 ]; then
# here you first have to check if there is already a branch locally or remotely
# You have to check how many you have
# if you have remotely and locally check which is more up to date or if they should be merge. Maybe try to pull and throw an error if not possible
# git checkout "$issue_prefix/$jira_issue$issue_summary" || error 1
# else
git checkout -b "$issue_prefix"/"$jira_issue"_"$issue_summary" origin/main || error 1
# fi
