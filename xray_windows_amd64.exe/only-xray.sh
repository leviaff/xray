#!/bin/bash

echo domain
read domain

current_date=$(date +'%Y-%m-%d_%H-%M-%S')
./xray.exe ws --basic-crawler "$domain" --plugins sqldet --ho "C:/Users/levia/Documents/bugbounty/$domain/xray/$current_date.html"

