#!/bin/bash
#script to add, commit, and push git chnages

#TODO:
#   * only run subsequent commands if previous successful
#   * tailor output (e.g., "done!" depending on success/failure of previous command
#   * add to path

pwd

#git:
echo "adding all files to git..."
git add ./*
echo "done!"

read -r -p "enter commit message:  " cm
echo "committing..."
git commit -m "$cm"
echo "done!"

echo "pushing changes to GitHub..."
git push origin "$(git rev-parse --abbrev-ref HEAD)"
echo "done!"
