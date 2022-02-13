#!/bin/bash

# Create Database
function createDB
{
	echo "Enter Unique Database Name :"
	read Name

	#Check if Entered database exists
	if [ -z $Name ]
	then
		echo "You Must Enter Valid Name"
		./backtoMenus.sh 1
		exit
	else 
		source ./showDbs.sh "existed" $Name
	fi

	if [ $dbExist -eq 0 ]
	then
		#create Database directory and Schema
       	mkdir databases/$Name 
        touch databases/$Name/Schema

		echo "DataBase $Name Successfully Created"
		./backtoMenus.sh 1
		exit
	else 
		echo "DataBase Already Exsits"
		./backtoMenus.sh 1
		exit
	fi

}

createDB

