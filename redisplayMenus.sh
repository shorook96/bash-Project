#!/bin/bash

# Display Menus
case $1 in
    1) 
        echo "1) Create Database	3) Connect To Database	5) Exit
2) List Databases	4) Drop Database"
        
    ;;
    2)
        echo "1) Create Table	      4) Insert into Table  7) Exit
2) List Tables	      5) Select From Table 
3) Drop Table	      6) Delete From Table "
    ;;
    *) echo "invaled option"
    ;;
esac

