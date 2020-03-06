#!/usr/bin/bash
#FellFreeToRecode
cyan='\e[0;36m'
green='\e[0;34m'
okegreen='\033[92m'
lightgreen='\e[1;32m'
white='\e[1;37m'
red='\e[1;31m'
yellow='\e[1;33m'
BlueF='\e[1;34m'
clear
BANNERS () {
printf "${lightgreen}==============================
     ╔═╗┌─┐┌┐┌┌┬┐┌─┐
     ╚═╗├┤ │││ │ │ │
     ╚═╝└─┘┘└┘ ┴ └─┘      
${white}  xss scanner with api
${white}nakanosec.com - n45ht.or.id${lightgreen}
==============================\n
"
}
BANNERS
OPTIONS () {
printf "${red}[>]${white} List                        :${lightgreen} "
read list
printf "${red}[>]${white} Save As                     :${lightgreen} "
read save
site=$(cat $list)
}
OPTIONS
printf "\n${lightgreen}Now Checking...\n\n"
for site in $(cat $list);
do
if [[ $(curl --connect-timeout 5 --max-time 5 -kLs "https://api.n45ht.or.id/v1/xss-scanner?url=${site}/" ) =~ "XSS found" ]]; then
payload=$(curl -kls https://api.n45ht.or.id/v1/xss-scanner?url=${site} | grep -Po '"poc":"\K.*?(?=#n45ht)'| sed 's/\\//g' );  
printf "${white}[+] ${site} is ${lightgreen} vuln\n${white}     > Payload: ${lightgreen}${payload}"
  echo "$site/" >> ${save}
else
  printf "${white}\n[+] ${site} is ${red} Bad\n"
fi
done
printf "\n${lightgreen}Save as ${save}...\n\n"
