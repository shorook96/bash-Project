#!/bin/bash

# Drop Table
function dropTable
{
	echo "Enter Table Name:"
	read tbName

	#Check if table exists
	if [ -z $tbName ]
	then
		echo "You Must Enter Valid Name"
		./backtoMenus.sh 2
		exit
	else
		source ./listTables.sh "existed" $tbName
	fi

	if [ $tableExist -eq 0 ]
	then
		echo "There is no table by this name"
		./backtoMenus.sh 2
		exit
	else 
		rm  databases/$currentDb/$tbName 
		rm  databases/$currentDb/${tbName}_Schema 
		sed -i "/$tbName,/d" "databases/$currentDb/Schema" 
		echo "Table $tbName Deleted Correctly"
		./backtoMenus.sh 2
		exit
	fi
}

dropTable
