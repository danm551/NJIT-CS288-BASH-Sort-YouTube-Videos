##Homework 3. Takes an html file (wget -O index.html URL) and extracts titles, views, users, and injects the data into a .csv file##

#!/bin/sh

#grabs views from .html file
j=0
s=()
s=$(egrep -o '(([0-9]+,)+[0-9]+ views)' index.html | egrep -o '(([0-9]+,)+[0-9]+)')
s=${s//,/}
for i in $s
do
	echo $i
done > views.txt

#grabs user names from .html file. Not 100% figured out
s=$(egrep -o 'by <a href="/channel/[a-zA-Z0-9]*|/user/[a-zA-Z0-9]*' index.html)
for i in $s
do
	echo $i
done > users.txt

#grabs duration from .html file
s=$(egrep -o 'Duration: [0-9]*:[0-9]+' index.html | egrep -o [0-9]*:[0-9]+)
for i in $s
do
	echo $i
done > duration.txt

#grabs titles from .html file
egrep 'Duration' index.html | egrep -o 'title=".*" aria-describedby' | egrep -o 'title=".*"' | egrep -o '".*"' > title.txt
count=0
while read i
do
	list=("${list[@]}" "$i")
done < title.txt

#replaces " , " with MY_COMMA in titles
size=${#list[@]}
for((i = 0; i < size; i++))
do
	s=${list[((i))]}
	s=${s//,/MY_COMMA}
	echo $s
done > title.txt

paste -d, views.txt title.txt> all.csv

