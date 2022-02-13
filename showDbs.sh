#!/bin/bash

# List Databases
if [ $1 == "list" ]
then
	num=0 
	for elementofdb in `ls databases`
	do
		((num=num+1))
		echo "$num- $elementofdb"
	done
	./backtoMenus.sh 1
	exit

# Check if Database exist
elif [ $1 == "existed" ]
then 
	dbExist=0
	for elementofdb in `ls databases`
	do
		if [ $2 = $elementofdb ]
		then
			dbExist=1
		fi
	done	
		
fi
