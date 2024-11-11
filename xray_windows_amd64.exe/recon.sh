#!/bin/bash

echo "Masukkan domain:"
read domain

base_path="C:/Users/levia/Documents/bugbounty/$domain"

subfinder -d "$domain" -silent | anew "$base_path/subs.txt"
./assetfinder.exe -subs-only "$domain" | anew "$base_path/subs.txt"
amass enum -passive -d "$domain" | anew "$base_path/subs.txt"