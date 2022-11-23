#!/bin/bash

set -uo pipefail
#set -x

WebSiteListFile="$1"

if [ -z "$WebSiteListFile" ]
then 
    echo "Please specify the website list file!"
else
    while IFS= read -r line
    do 
        weburl="$line"
        echo "$weburl"
        output=$(echo | openssl s_client -servername "$weburl" -connect "$weburl":443 2>/dev/null | openssl x509 -text 2>/dev/null | egrep 'Subject:|Not')
        if [[ $? -eq 0 ]]
        then
            subject=$(echo "$output" | awk '/Subject:/ {print}' | sed 's/^ *//g')
            notBefore=$(echo "$output" | awk '/Not Before/ {print}' | sed 's/^ *//g')
            notAfter=$(echo "$output" | awk '/Not After/ {print}' | sed 's/^ *//g')
            echo \"$weburl\",\"$subject\",\"$notBefore\",\"$notAfter\" >> result.csv
        else
            subject="N/A"
            notBefore="N/A"
            notAfter="N/A" 
            echo \"$weburl\",\"$subject\",\"$notBefore\",\"$notAfter\","Certificate checking failed. Unable to connect to the website." >> result.csv
        fi
    done < $WebSiteListFile
fi

