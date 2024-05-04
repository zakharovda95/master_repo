#!/bin/bash

git submodule update --init --recursive --remote

declare -A branches=(
    ["HelperClassLib"]="master"
    ["ModuleBot"]="master"
    # Добавьте сюда другие подмодули и ветки при необходимости
)

for submodule in $(git submodule status --recursive | awk '{print $2}'); do

    submodule_name=$(basename "$submodule")

    if [ -n "${branches[$submodule_name]}" ]; then
        branch=${branches[$submodule_name]}

        cd "$submodule" || exit

        echo "Entering '$submodule_name'"
        git checkout "$branch" && git pull origin "$branch"

        cd - || exit
    fi
done

read -p "Нажмите Enter для выхода"
