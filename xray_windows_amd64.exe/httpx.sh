#!/bin/bash

echo "Masukkan domain:"
read domain
base_path="C:/Users/levia/Documents/bugbounty/$domain"

cat "$base_path/subs.txt" | httpx -silent | anew "$base_path/alive.txt"
