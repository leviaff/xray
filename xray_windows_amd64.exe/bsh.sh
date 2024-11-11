#!/bin/bash

echo Masukan domain!!
read domain
mkdir C:/Users/levia/Documents/bugbounty/$domain
mkdir C:/Users/levia/Documents/bugbounty/$domain/xray

subfinder -d $domain -silent | anew C:/Users/levia/Documents/bugbounty/$domain/subs.txt
./assetfinder.exe -subs-only $domain | anew C:/Users/levia/Documents/bugbounty/$domain/subs.txt
amass enum -passive -d $domain | anew C:/Users/levia/Documents/bugbounty/$domain/subs.txt

cat C:/Users/levia/Documents/bugbounty/$domain/subs.txt | httpx -silent | anew C:/Users/levia/Documents/bugbounty/$domain/alive.txt

## Test by Xray
current_date=$(date +'%Y-%m-%d_%H-%M-%S')
for i in $(cat C:/Users/levia/Documents/bugbounty/$domain/alive.txt); do ./xray.exe ws --basic-crawler $i --plugins sqldet --ho C:/Users/levia/Documents/bugbounty/$domain/xray/$current_date.html ; done

## test for nuclei

cat C:/Users/levia/Documents/bugbounty/$domain/alive.txt | nuclei -t C:/Users/levia/nuclei-templates -es info,unknown -etags ssl,network | anew C:/Users/levia/Documents/bugbounty/$domain/nuclei.txt