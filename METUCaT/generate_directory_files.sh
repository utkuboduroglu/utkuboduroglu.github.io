#!/usr/bin/bash

# for the specified directory $1, read each file in the directory
# and create `index.md` with links to each file

# assume $1 exists
WORKING_DIRECTORY=$1
WORKING_FILE=$WORKING_DIRECTORY/index.md

# insert header
## instead of subfile_header.txt, use << EOF
if [ -f $WORKING_DIRECTORY/header.txt ]; then
    echo "[$0 : header_custom] Found a custom header.txt file for $1"
    cat $WORKING_DIRECTORY/header.txt > $WORKING_FILE
else

echo "[$0 : header_write] Writing header $WORKING_DIRECTORY"
cat << EOF > $WORKING_FILE
---
layout: page
title: $WORKING_DIRECTORY
---

EOF

fi

# find all non-index files in the working directory and insert them into index.md
while IFS= read -r _file
do
	echo -ne "\t[$0 : insert_file] "

    _raw_datestring=$(stat -c %Y $_file)
    _file_modification_time=$(date -d @$_raw_datestring +%x\ %T)
    _base_filename=${_file##*/}
	echo -ne \
        "* [$_base_filename](./$_base_filename)\n\t* **modified**: $_file_modification_time\n" \
        | tee -a $WORKING_FILE

done < <( \
    find $WORKING_DIRECTORY -type f -not -path '*index.md' -not -path '*header.txt' -printf '%p %C@\n' \
        | sort -k2,2 -r | awk '{ print $1 }' \
    )
# for file in $FILES
# echo -ne "* [file-name](file-path)\n" >> $WORKING_FILE
