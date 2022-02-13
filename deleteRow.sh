#!/bin/bash

# Delete Rows
function deleteRow
{
	echo "Enter Table Name:"
	read tbName

	#Check if table exists
	if [ -z $tbName ]
	then
		echo "You Must Enter Valid Name"
		exit
	else
		source ./listTables.sh "existed" $tbName
	fi

	if [ $tableExist -eq 0 ]
	then
		echo "Error, table dose not exist"
		./backtoMenus.sh 2
		exit
	else
		PS3="bashProject-${tbName}>"
		select choice in "Delete All Data" "Delete Special Rows" "Exit"
		do
			case $REPLY in
				1) 
					`sed -i '1,$d' databases/$currentDb/$tbName`
					echo "All $tbName Rows Are Deleted"
					./backtoMenus.sh 2
					exit
				;;
				2)
					checkColumn
					./backtoMenus.sh 2
					exit
				;;
				3)
					./backtoMenus.sh 2
					exit
				;;				
				*) echo "invaled option"
				;;
			esac
		done 
        
	fi
}

function checkColumn
{
	echo "Enter Column Name:"
	read columnName

	column=$(awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++){if($i=="'$columnName'") print $i}}' databases/$currentDb/${tbName}_Schema)
	if [[ $column = "" ]]
	then
		echo "Invalid Column"
		#checkColumn
	else
		checkCoulmnWithValue
		echo "All data have this value are deleted"
	fi
}

function checkCoulmnWithValue 
{
	echo "Enter Column Value:"
	read columnValue
	typeset arrayRows[2]
	index=0

	columnVal=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++){if($i=="'$columnName'"){j=i+1; if($j == "'$columnValue'"){print NR}}}}' databases/$currentDb/$tbName `
	for i in $columnVal
	do
		arrayRows[$index]=$i
		(( index+=1 ))
	done

	(( index=1 ))
	line=""
	for i in ${arrayRows[*]}
	do
		if [ $index -eq ${#arrayRows[*]} ]
		then
			line+="${i}d" 
		else
			line+="${i}d;" 
		fi
		(( index+=1 ))
	done
	`sed -i $line databases/$currentDb/$tbName`
}

deleteRow
