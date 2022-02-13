#!/bin/bash

#Create Table
function createTable
{
        echo "Enter Unique Table Name:"
        read tableName

        #Check if table exists
        if [ -z $tableName ]
        then
                echo "You Must Enter Valid Name"
                ./backtoMenus.sh 2
                exit
        else 
                source ./listTables.sh "existed" $tableName
        fi

        if [ $tableExist -eq 0 ]
        then
                #create Table directory and Schema
                touch databases/$currentDb/$tableName
                touch databases/$currentDb/${tableName}_Schema
                echo "$tableName" >> databases/$currentDb/Schema

                echo "Table $tableName Successfully Created"
                insertCoulmn
                ./backtoMenus.sh 2
                exit
        else
                echo "Table Already Exsits"
                ./backtoMenus.sh 2
                exit
        fi
}

# Insert Column
function insertCoulmn
{
	echo "Number of columns:"
	read columnsNumber
	index=0
        if [[ $columnsNumber == +([0-9]) ]]
        then
            while ((index<columnsNumber))
	    do
                (( tracker=index + 1 ))
		echo "Enter Column $tracker"
		read column
		echo "Enter DataType:"
		read dataType
                checkColumn $column $dataType
                if [ $repeatFlag -eq 1 ]
                then
                        echo "$column is Duplicated column name "
		elif [ $dataTypeIsExist -eq 0 ]
                then
                        echo "Datatype dose not exist"
                else
                       columnArray[$index]=$column
                       echo  "$column,$dataType," >> databases/$currentDb/${tableName}_Schema
                       echo  "$column,$dataType," >> databases/$currentDb/Schema
                       (( index+=1 ))
                fi
             done
        else 
                echo "Enter Valid Number"
                insertCoulmn
        fi
	

       addPrimary 
        
}

# Check Column
typeset columnArray[2]
function checkColumn
{
        repeatFlag=0
        for i in ${columnArray[@]}
        do
                if [ $i = $1 ]
                then
                        repeatFlag=1
                        break
                fi
        done
        source ./dataType.sh "check" $2
}

# Adding Primary Key
function addPrimary
{
        echo "Enter Primary Key:"
        read primaryKey
        isExistFlag=0
        for i in ${columnArray[@]}
        do
                if [ $i = $primaryKey ]
                then
                        (( isExistFlag=1 ))
                        break
                fi
        done
        if [ $isExistFlag -eq 0 ]
        then
                echo "Invalid column"
                addPrimary
        else
                echo  "$primaryKey" >> databases/$currentDb/${tableName}_Schema
                echo  "$primaryKey" >> databases/$currentDb/Schema        
        fi
}

createTable



