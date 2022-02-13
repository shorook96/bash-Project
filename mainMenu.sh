#!/bin/bash

PS3="bashProject>"
databasesIsCreated=0
function createDatabaseFolder
{
    for elementOfList in `ls`
            do
            if [ $elementOfList == "databases" ]
            then
                databasesIsCreated=1
                break
            fi
    done
    if [ $databasesIsCreated -eq 0 ]
    then
        mkdir databases 
    fi
}
createDatabaseFolder

# Change all files permissions
function changePermissions
{
	for scriptFile in `ls`
	do
		chmod +x $scriptFile
	done
}
changePermissions

select choice in "Create Database" "Show Databases" "Use Database" "Drop Database" "Exit"
do
    case $choice in
        "Create Database") 
            echo "Creating database"
            ./createDb.sh
        ;;
        "Show Databases")
            echo "Show databases"
            ./showDbs.sh "list"
        ;;
        "Use Database")
            echo "Connecting to a database"
            ./useDb.sh
        ;; 
        "Drop Database")
            echo "Dropping a database"
            ./dropDb.sh
        ;;
        "Exit")
            echo "bashProject Exit"
	    exit
        ;;
        *) echo "invaled option"
        ;;
    esac
done
