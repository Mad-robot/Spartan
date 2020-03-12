#!/bin/bash

YELLOW="\033[1;33m"
GREEN="\033[0;32m"
RED="\033[0;31m"
RESET="\033[0m"

echo -e "
                      
___________.__    .__         .___           _________                    __                  
\__    ___/|  |__ |__| ______ |   | ______  /   _____/__________ ________/  |______    ____   
  |    |   |  |  \|  |/  ___/ |   |/  ___/  \_____  \\____ \__  \\_  __ \   __\__  \  /    \  
  |    |   |   Y  \  |\___ \  |   |\___ \   /        \  |_> > __ \|  | \/|  |  / __ \|   |  \ 
  |____|   |___|  /__/____  > |___/____  > /_______  /   __(____  /__|   |__| (____  /___|  / 
                \/        \/           \/          \/|__|       \/                 \/     \/   - by $RED@madrobot$RESET
	"
sleep 2;


echo -e "[$GREEN+$RESET] Installing Dependencies";
sudo apt-get install git;
sudo apt install curl;
sudo apt install ruby;
sudo apt install ruby-dev;
sudo apt-get install make;
sudo apt install golang-go;
sudo apt install python3;
sudo apt install python3-pip;
curl -sL https://deb.nodesource.com/setup_8.x | sudo bash - ;
sudo apt-get install -y nodejs ;
sudo apt install nmap;
sudo apt install masscan;
sudo apt-get install dnsutils;
sudo add-apt-repository ppa:canonical-chromium-builds/stage
sudo apt update
sudo apt install chromium-browser
sudo apt-get update -y;
sudo apt-get upgrade -y;
echo -e "[$GREEN+$RESET] Done.";

echo -e "[$GREEN+$RESET] Creating directories..";
mkdir -p $HOME/Recon;
mkdir -p $HOME/go;
mkdir -p $HOME/go/src;
mkdir -p $HOME/go/bin;
mkdir -p $HOME/go/pkg;
echo -e "[$GREEN+$RESET] Done.";

echo -e "[$GREEN+$RESET] Adding recon alias & Golang to .bashrc..";
sleep 1;
echo -e 'export GOPATH=$HOME/go' >> $HOME/.bashrc;
echo -e 'export GOROOT=/usr/local/go' >> $HOME/.bashrc;
echo -e 'export PATH=$PATH:$HOME/go/bin/' >> $HOME/.bashrc;
echo -e 'export PATH=$PATH:$GOROOT/bin' >> $HOME/.bashrc;
echo -e 'export PATH=$PATH:$HOME/.local/bin' >> $HOME/.bashrc;
echo -e "alias httprobe='$HOME/go/bin/httprobe'" >> $HOME/.bashrc;
sleep 1;
source $HOME/.bashrc;
cd $HOME  || return;
echo -e "[$GREEN+$RESET] Done.";

echo -e "[$GREEN+$RESET] Installing Aquatone";
gem install aquatone;
go get github.com/michenriksen/aquatone;
echo -e "[$RED+$RESET] Aquatone needs API keys to work";
sleep 2;
echo -e "----========++++========----";
echo -e "Go to riddler.io and sign up ";
read -p "Enter riddler_username: " riddler_username;
read -p "Enter riddler_password: " riddler_password;

aquatone-discover --set-key riddler_username $riddler_username ;
aquatone-discover --set-key riddler_password $riddler_password ;
echo -e "----========++++========----";
echo -e "Go to shodan.io and sign up " ;
sleep 2;
read -p "Enter shodan: " shodan ;
aquatone-discover --set-key shodan $shodan ;
echo -e "----========++++========----";
echo -e "Go to community.riskiq.com and sign up " ;
read -p "Enter passivetotal_key: " passivetotal_key ;
read -p "Enter passivetotal_secret: " passivetotal_secret ;
aquatone-discover --set-key passivetotal_key $passivetotal_key ;
aquatone-discover --set-key passivetotal_secret $passivetotal_secret ;
echo -e "----========++++========----";
echo -e "Go to censys.io and sign up ";
read -p "Enter censys_id: " censys_id;
read -p "Enter censys_secret: " censys_secret;
aquatone-discover --set-key censys_id $censys_id ;
aquatone-discover --set-key censys_secret $censys_secret ;
echo -e "----========++++========----";
echo -e "Go to virustotal.com and sign up ";
read -p "Enter virustotal: " virustotal;
aquatone-discover --set-key virustotal $virustotal ;
echo -e "----========++++========----";
echo -e "All keys will be saved in ~/aquatone/.keys.yml";

echo -e "[$GREEN+$RESET] Done.";

echo -e "[$GREEN+$RESET] Installing Sublist3r & Requirements ";
cd $HOME || return;
sleep 1;
git clone https://github.com/aboul3la/Sublist3r;
pip3 install -r $HOME/Sublist3r/requirements.txt;
echo -e "[$GREEN+$RESET] Done."

echo -e "[$GREEN+$RESET] Installing httprobe & waybackurls";
cd $HOME || return;
sleep 1;
go get -u github.com/tomnomnom/httprobe;
go get github.com/tomnomnom/waybackurls;
echo -e "[$GREEN+$RESET] Done."

echo -e "[$GREEN+$RESET] Installing dirsearch ";
cd $HOME || return;
sleep 1;
git clone https://github.com/maurosoria/dirsearch;
echo -e "[$GREEN+$RESET] Done."

echo -e "[$GREEN+$RESET] Installing CMSeeK & Requirements ";
cd $HOME || return;
sleep 1;
git clone https://github.com/Tuhinshubhra/CMSeeK;
pip3 install -r $HOME/CMSeeK/requirements.txt;
echo -e "for line in $(cat "/$HOME/Recon/$1/final_urls.txt");do python3 $HOME/CMSeeK/cmseek.py -u "$line" --no-redirect; done" > ./CMSeeK/sc;
chmod +x ./CMSeeK/sc
echo -e "[$GREEN+$RESET] Done."


echo -e "[$GREEN+$RESET] Moving Spartan ";
cp /$HOME/Spartan/spartan /bin/spartan
chmod +x /bin/spartan
echo -e "[$GREEN+$RESET] Done."
