#!/bin/bash

# Drop Database
function dropDB
{
	echo "Enter Database Name: "
	read Name

	#Check if database exists
	if [ -z $Name ]
	then
		echo "You Must Enter Valid Name"
		./backtoMenus.sh 1
		exit
	else 
		source ./ShowDbs.sh "existed" $Name
	fi

	if [ $dbExist -eq 0 ]
	then
		echo "There is no database with this name"
		./backtoMenus.sh 1
		exit
	else 
		rm -r databases/$Name 
		echo "DataBase $Name is Removed successfully"
		./backtoMenus.sh 1
		exit
	fi

}

dropDB
