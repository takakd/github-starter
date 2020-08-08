#!/usr/bin/env bash

DEFAULT_LOCAL_REPO_ROOT_DIR=${HOME}

/bin/echo -n "What is the repository URL?: "
read repo_url

/bin/echo -n "Where is the directory path that the local directory placed? ["$DEFAULT_LOCAL_REPO_ROOT_DIR"]: "
read dir_path
if [[ "$dir_path" = "" ]]; then
    dir_path="$HOME"
fi

# Get repository name excluded ".git".
repo_name=$(basename "$repo_url" | sed -e 's/.git$//')

repo_path="$dir_path/$repo_name"
if [[ -e "$repo_path" ]]; then
    /bin/echo -n "Directory exists. Overwrite OK?[Y/n]: "
    read ok
    if [[ "$ok" != "Y" && "$ok" != "y" ]]; then
        exit
    fi

    rm -rf "$repo_path"
fi

git clone "$repo_url" "$repo_path"
cp -f ./template/* "$repo_path"
cd "$repo_path"
git add --all
git commit -m "Add: github-starter files."