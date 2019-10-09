#!/bin/bash
db2 connect to scopedb
db2 SET SCHEMA "SCOPE"
for folder_name in tablespace tables aliases riconstraints functions views functions aliases index storedproc triggers scripts
do
	echo "Looking for sql files in the $folder_name"
	cd $folder_name
	touch test.txt test
    ls *.sql >> test.txt
	sort -g test.txt > test
	file="test"
	while IFS='' read -r line || [[ -n "$line" ]]
	do
		echo "Name of file :${line}"
		db2 -td@ -mvf $line > $line.log
	done < "$file"
	rm test.txt
	rm test
	cd ..
done
