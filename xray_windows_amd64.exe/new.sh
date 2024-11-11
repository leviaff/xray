#!/bin/bash

echo "Masukkan domain:"
read domain

# Menyiapkan path
base_path="$HOME/Documents/bugbounty/$domain"

# Membuat direktori
mkdir -p "$base_path"
mkdir -p "$base_path/xray"

# Mengumpulkan subdomain
subfinder -d "$domain" -silent | anew "$base_path/subs.txt"
./assetfinder -subs-only "$domain" | anew "$base_path/subs.txt"
amass enum -passive -d "$domain" | anew "$base_path/subs.txt"

# Memeriksa ketersediaan subdomain
httpx -silent -l "$base_path/subs.txt" | anew "$base_path/alive.txt"

## Test dengan Xray
while IFS= read -r i; do
    current_date=$(date +'%Y-%m-%d_%H-%M-%S')
    ./xray.exe ws --basic-crawler "$i" --plugins sqldet --ho "$base_path/xray/$current_date.html"
done < "$base_path/alive.txt"

## Test dengan Nuclei
nuclei -l "$base_path/alive.txt" -t "$HOME/nuclei-templates" -es info,unknown -etags ssl,network,http -severity low,medium,high -o "$base_path/nuclei.txt"