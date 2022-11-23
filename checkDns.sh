#!/bin/bash

set -uo pipefail
#set -x

CheckAgainstFile () {
WebSiteListFile="$1"
OutputFile="result.csv"
string_notfound='not found: '

if [ -z "$WebSiteListFile" ]
then 
    echo "Please specify the website list file!"
else
    #echo "URL,Subject,Begin,End,Issuer,Comments" > $OutputFile
    while IFS= read -r line
    do 
        weburl="$line"
        #echo "$weburl"
        output=$(echo | host "$weburl" )
        if [[ "$output" == *"$string_notfound"* ]]
        then
            echo "$weburl does not exist"
        else
            echo "$weburl exists"
        fi
    done < $WebSiteListFile
fi
}

CheckAgainstURL () {

string_notfound='not found:'

if [ -z "$SingleURL" ]
then 
    echo "Please specify the URL!"
else
     output=$(echo | host "$SingleURL" )
   if [[ "$output" == *"$string_notfound"* ]]
   then
        echo "$SingleURL does not exist"
   else
        echo "$SingleURL exists"
   fi
fi
}


while getopts :u:f: option; do 
    case $option in 
        u) SingleURL=$OPTARG
           CheckAgainstURL;;
        f) ListFile=$OPTARG
           CheckAgainstFile "$ListFile";;
        ?) echo "Please use the correct flag. -u <URL> for single URL, -f <FileName> for a list file."
           exit 1;;
    esac
done