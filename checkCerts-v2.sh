#!/bin/bash

set -o pipefail
#set -x

CheckAgainstFile () {
WebSiteListFile="$1"
OutputFile="result.csv"
if [ -z "$WebSiteListFile" ]
then 
    echo "Please specify the website list file!"
else
    echo "URL,Subject,Begin,End,Issuer,Comments" > $OutputFile
    while IFS= read -r line
    do 
        weburl="$line"
        #echo "$weburl"
        output=$(echo | timeout 2 openssl s_client -servername "$weburl" -connect "$weburl":443 2>/dev/null | openssl x509 -text 2>/dev/null | egrep 'Subject:|Not|Issuer')
        if [[ $? -eq 0 ]]
        then
            issuer=$(echo "$output" | awk '/Issuer:/ {print}' | sed 's/^ *//g')
            subject=$(echo "$output" | awk '/Subject:/ {print}' | sed 's/^ *//g')
            notBefore=$(echo "$output" | awk '/Not Before/ {print}' | sed 's/^ *//g')
            notAfter=$(echo "$output" | awk '/Not After/ {print}' | sed 's/^ *//g')
            echo "Checking $weburl ..."
            echo \"$weburl\",\"$subject\",\"$notBefore\",\"$notAfter\",\"$issuer\" >> $OutputFile
        else
            subject="N/A"
            notBefore="N/A"
            notAfter="N/A"
            issuer="N/A" 
            echo "Checking $weburl ..."
            echo \"$weburl\",\"$subject\",\"$notBefore\",\"$notAfter\",\"$issuer\","Certificate checking failed. Unable to connect to the website." >> $OutputFile
        fi
    done < $WebSiteListFile
    echo "All the outputs have been saved in the $OutputFile file"
fi
}

CheckAgainstURL () {

if [ -z "$SingleURL" ]
then 
    echo "Please specify the URL!"
else
     output=$(echo | timeout 2 openssl s_client -servername "$SingleURL" -connect "$SingleURL":443 2>/dev/null | openssl x509 -text 2>/dev/null | egrep 'Subject:|Not|Issuer')
    if [[ $? -eq 0 ]]
    then
        issuer=$(echo "$output" | awk '/Issuer:/ {print}' | sed 's/^ *//g')
        subject=$(echo "$output" | awk '/Subject:/ {print}' | sed 's/^ *//g')
        notBefore=$(echo "$output" | awk '/Not Before/ {print}' | sed 's/^ *//g')
        notAfter=$(echo "$output" | awk '/Not After/ {print}' | sed 's/^ *//g')
        echo -e "URL:"\"$SingleURL\""\n"$subject"\n"$notBefore"\n"$notAfter"\n"$issuer
    else
        subject="N/A"
        notBefore="N/A"
        notAfter="N/A"
        issuer="N/A"
        echo -e "URL:"\"$SingleURL\""\n"$subject"\n"$notBefore"\n"$notAfter"\n"$issuer"\nCertificate checking failed. Unable to connect to the website."
    fi
fi
}


while getopts "u:f:" option; do 
    case $option in 
        u) SingleURL=$OPTARG
           CheckAgainstURL
           ;;
        f) ListFile=$OPTARG
           CheckAgainstFile "$ListFile"
           ;;
        *) echo "Please use the correct flag. -u <URL> for single URL, -f <FileName> for a list file."
           exit 1
           ;;
    esac
done


