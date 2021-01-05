#!/bin/bash

### Set initial time of file
LTIME=`stat -c %Z $1`

### A script to compile latex if a change is made to file
### polling every 5 seconds
while true    
do
   ATIME=`stat -c %Z $1`

   if [[ "$ATIME" != "$LTIME" ]]
   then    
       echo "RUN COMMAND"
       xelatex main.tex && firefox main.pdf
       LTIME=$ATIME
   fi
   sleep 5
done

