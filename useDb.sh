#!/bin/bash

# Select Database
function selectDB
{
	echo "Enter Database Name:"
	read dbName

	#Check if database exists
	if [ -z $dbName ]
	then
		echo "You Must Enter A Valid Name"
		./backtoMenus.sh 1
		exit
	else 
		source ./showDbs.sh "existed" $dbName
	fi

	if [ $dbExist -eq 0 ]
	then
		echo "There is no database with this name"
		./backtoMenus.sh 1
		exit	
	else
		currentDb=$dbName 
		echo "Database $dbName is Successfully Selected"
		export currentDb
		./tableMenu.sh
	fi

}

selectDB
