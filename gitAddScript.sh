#!/bin/bash

echo "$1" >> README.md
git init
git add -A
git commit -m "$2"
git branch -M main
git remote add origin $3
git push -u origin main
