#!/bin/bash

echo "Masukkan domain:"
read domain

base_path="C:/Users/levia/Documents/bugbounty/$domain"

mkdir -p "$base_path"
mkdir -p "$base_path/xray"

subfinder -d "$domain" -silent | anew "$base_path/subs.txt"
./assetfinder.exe -subs-only "$domain" | anew "$base_path/subs.txt"
amass enum -passive -d "$domain" | anew "$base_path/subs.txt"

cat "$base_path/subs.txt" | httpx -silent | anew "$base_path/alive.txt"

## Test by Xray

while IFS= read -r i; do
    current_date=$(date +'%Y-%m-%d_%H-%M-%S')
    ./xray.exe ws --basic-crawler "$i" --plugins sqldet,xss --ho "C:/Users/levia/Documents/bugbounty/$domain/xray/$current_date.html"
done < "C:/Users/levia/Documents/bugbounty/$domain/alive.txt"

## Test for nuclei

nuclei -l "$base_path/alive.txt" -t "C:/Users/levia/nuclei-templates" -es info,unknown -etags ssl,network,http -severity low,medium,high -o "$base_path/nuclei.txt"
