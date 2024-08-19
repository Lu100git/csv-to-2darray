#!/bin/sh

input=`mktemp -t tempXXXXXX`
input2=`mktemp -t tempXXXXXX`
input3=`mktemp -t tempXXXXXX`
input4=`mktemp -t tempXXXXXX`
temp_path=`mktemp -t tempXXXXXX`
path=`mktemp -t tempXXXXXX`
temp_save_path=`mktemp -t tempXXXXXX`


deleteTempFiles(){
  rm -f $input 2> /dev/null
  rm -f $input2 2> /dev/null
  rm -f $input3 2> /dev/null
  rm -f $input4 2> /dev/null
  rm -f $temp_path 2> /dev/null
  rm -f $path 2> /dev/null 
  rm -f $temp_save_path 2> /dev/null
}


zenity --question  --title="CSV to 2D array By: Lu" --text="this is a simple csv file converter into a C++ 2D array data file, do you wish to proceed?"
case $? in
  1)
    zenity --info --text "HAVE A GOOD DAY! 🙂" --title="CSV to 2D array By: Lu"
    echo "Have a good day!" 
    exit
    ;;
  -1)
    echo "An unexpected error has occurred.";;
esac


FILE=`zenity --file-selection --title="Select a CSV File"`
case $? in
  0)
    echo "\"$FILE\" selected."
    echo $FILE > $temp_path
    sed 's/ /\ /' $temp_path > $path
    rm -f $temp_path 2> /dev/null
    cat $path
    ;;
  1)
    echo "No file selected."
    zenity --info --text "HAVE A GOOD DAY! 🙂" --title="CSV to 2D array By: Lu"
    echo "Have a good day!"
    deleteTempFiles
    exit
    ;;
  -1)
    echo "An unexpected error has occurred.";;
esac

zenity --entry --title="CSV to 2D array By: Lu" --text="Enter the 2D array name:" --entry-text="map_tiles" --width 400 --height 200 > $input
if [ $? -eq 1 ];then
  deleteTempFiles
  zenity --info --text "HAVE A GOOD DAY! 🙂" --title="CSV to 2D array By: Lu"
  exit
fi
array=`cat $input`

zenity --entry --title="CSV to 2D array By: Lu" --text="Enter the map width:" --entry-text="60" --width 400 --height 200 > $input2
if [ $? -eq 1 ];then
  deleteTempFiles
  zenity --info --text "HAVE A GOOD DAY! 🙂" --title="CSV to 2D array By: Lu"
  exit
fi
width=`cat $input2`

zenity --entry --title="CSV to 2D array By: Lu" --text="Enter the map height:" --entry-text="40" --width 400 --height 200 > $input3
if [ $? -eq 1 ];then
  deleteTempFiles
  zenity --info --text "HAVE A GOOD DAY! 🙂" --title="CSV to 2D array By: Lu"
  exit
fi
height=`cat $input3`

echo "int $array[$height][$width] = {" > temp

path_data=`cat $path`
awk '{print "{" $1 "},"}' "${path_data}" >> temp

truncate -s -1 temp
truncate -s -1 temp

echo " " >> temp
echo "}" >> temp

zenity --file-selection --save  --title="2D array data destination" > $temp_save_path

case $? in
  0)
    save_path=`sed 's/ /\\ /' $temp_save_path`
    rm -f $temp_save_path 2> /dev/null
    echo $save_path
    ;;
  1)
    echo "File not saved";;
  -1)
    echo "An unexpected error has occurred.";;
esac

cat temp > $save_path

rm temp
deleteTempFiles

zenity --info --text "csv to 2d array is done HAVE A GOOD DAY! 🙂" --title="CSV to 2D array By: Lu"


