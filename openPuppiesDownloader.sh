#!/bin/sh

if [ $# -ne 0 ]; then
    cd $1
fi

json=$(curl -s https://raw.githubusercontent.com/heyitsolivia/secretpuppies/gh-pages/puppies.json) #download the json file containing the names of all the online files

delimiter="\""

while [ "${json/$delimiter}" != "$json" ] #while the file still has delimiters, it still has items
do
  json="${json#*$delimiter}" #remove everything up to and including the first quotation mark
  sub="${json%%$delimiter*}" #the substring contains everything up to and including the new first quotation mark

  fileName="$sub"".mp4"
  myURL="http://openpuppies.com/mp4/"$fileName

  if [ ! -f $fileName ]; then #if the file does not already exist
    if [ $(curl -I  --stderr /dev/null $myURL | head -1 | cut -d' ' -f2) == 200 ]; then #if the website exists
      curl -Os $myURL #download file
    fi
  fi
  json="${json#*$delimiter}" #remove everything up to and including the first quotation mark
done

#for status updates on curl functions, remove the -s from the line
