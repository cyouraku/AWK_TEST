#!/bin/bash

echo "start to push to github"

git add *.*

echo $?

git commit -m "third commit"

echo $?

git push -u origin master

echo $?
