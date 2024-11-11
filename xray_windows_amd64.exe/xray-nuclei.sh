#!/bin/bash

echo "Masukkan domain:"
read domain

base_path="C:/Users/levia/Documents/bugbounty/$domain"

## Test by Xray

while IFS= read -r i; do
    current_date=$(date +'%Y-%m-%d_%H-%M-%S')
    ./xray.exe ws --basic-crawler "$i" --plugins sqldet,xss,upload,jsonp --ho "C:/Users/levia/Documents/bugbounty/$domain/xray/$current_date.html"
done < "C:/Users/levia/Documents/bugbounty/$domain/alive.txt"

## Test for nuclei

nuclei -l "$base_path/alive.txt" -t "C:/Users/levia/nuclei-templates" -es info,unknown -etags ssl,network,http -severity low,medium,high -o "$base_path/nuclei.txt"
