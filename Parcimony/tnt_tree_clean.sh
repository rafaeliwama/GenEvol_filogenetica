#!/bin/bash

get_trees() {
    local file_name="$1"
    local only_trees=()

    while IFS= read -r line; do
        if [[ $line == \(* ]]; then
            only_trees+=("$line")
        fi
    done < "$file_name"

    echo "${only_trees[@]}"
}

regex_trees() {
    local text="$1"
    text=$(echo "$text" | sed -E 's/\[[0-9]{1,3}\]//g; s/ ;/;/g; s/=/:/g; s/ :/:/g; s/ \)/)/g; s/ /,/g; s/\)\(/),(/g; s/(:[0-9]{1,3})\/([0-9]{1,3})/\2\1/g; s/\///g; s/\?//g')
    echo "$text"
}

tnttre_list() {
    local tnttre_files=()
    for file in *.tnttre; do
        if [[ -e $file ]]; then
            tnttre_files+=("$file")
        fi
    done
    echo "${tnttre_files[@]}"
}

write_trees() {
    local in_tree="$1"
    local tre_name="$2"

    local done
    done=$(get_trees "$in_tree")
    local tree_strings
    tree_strings=$(printf "%s\n" "$done")
    local tr_str
    tr_str=$(regex_trees "$tree_strings")

    echo "$tr_str" > "$tre_name"
}

tnt_all() {
    local all
    all=$(tnttre_list)
    for i in $all; do
        local i_tre="${i}.tre"
        write_trees "$i" "$i_tre"
    done
}

tnt_all
echo "Enjoy your trees!"
