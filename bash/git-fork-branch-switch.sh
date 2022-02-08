#!/bin/bash

input=$1;
inputArray=(`echo $input | sed 's/:/\n/g'`);

fork=${inputArray[0]};
branch=${inputArray[1]};

remote=(`echo $(git remote -v | grep -m1 origin) | sed 's/ /\n/g'`);
remoteUrl=${remote[1]};
upperUser=(`awk '{print toupper($0)}' <<< $USER`);
forkUrl=(`echo $remoteUrl | sed "s/$upperUser/$fork/g"`);

git remote add "$fork" "$forkUrl";
git fetch "$fork" "$branch";
git switch "$branch";
git pull "$fork" "$branch";

echo "Branch switched to $branch of fork $fork";
