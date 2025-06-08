#!/bin/bash
echo 'Welcome to My First Project'
echo 'Before beginning, the following details must be verified:'
echo '1) Ensure that you are in the correct directory before running the code.'
echo '2) Make sure Nipe tool not working at the background'


echo '_______________________________________'
echo ''
function TOOLKIT_PREP()
{
for MODULE  in sshpass whois torify 
do
CHECK=$(command -v $MODULE)
if  [ -z "$CHECK" ] # -z if the value is empty
then
echo 'The Tool is not installed:' $MODULE # MODULE value is these Tools " sshpass nipe torify nmap whois"
echo 'Begin the install'
sudo apt-get install $MODULE &>/dev/null #Configure the command to run silently without displaying output
else
echo 'The following Tool is installed' $MODULE 
fi
done
}
TOOLKIT_PREP
echo '_______________________________________'
echo
echo 'Exercise 2:'
function SEARCH_NIPE()
{
sudo updatedb
LOCATE_NIPE=(locate nipe.pl) #Here you locate the path of Nipe at the system.
echo ''
if [ -z "$LOCATE_NIPE" ] #If the path is Empty the install will run at the background.
then
echo 'The Tool Nipe is not Install, The installation running at the background' #start the install
cd ; git clone https://github.com/htrgouvea/nipe && cd nipe
sudo apt-get install cpanminus -y
sudo cpanm --installdeps . 
sudo perl nipe.pl install 
else
echo 'Nipe is allready install at the system'
path=$(command -v nipe.pl)
echo "The correct path of nipe is:" $(locate nipe.pl)
fi
}
SEARCH_NIPE

function HIDE_CHECK()
{
echo ''
echo '_______________________________________'
echo 'Exercise 3:'
EXTERNAL_IP=$(curl -s ident.me)  #My External IP
MY_CORRECT_COUNTRY=$(geoiplookup $EXTERNAL_IP |awk '{print$5}') #checking your correct Country from your Correct IP.
echo 'Your correct IP is:' $(curl -s ident.me)
echo 'Great now you are anonymous you not from israel your ip from:' $MY_CORRECT_COUNTRY
if [ "$MY_CORRECT_COUNTRY" == "Israel" ] #the system commpear if your "VPN" are working at the backgound or not.
then
echo 'You should not be here, please change to Anonymous'
echo 'Activating Nipe'
NIPE=$(sudo find / -name nipe -type d 2>/dev/null) #Find nipe directory location, suppress errors, and store path in NIPE variable(dev/null).
cd $NIPE
sudo perl nipe.pl status
sudo perl nipe.pl start
sudo perl nipe.pl restart
sudo perl nipe.pl status
echo 'Now You are good to go!'
echo 'Your new IP is:' $(grep 'ip')
sudo perl nipe.pl status
elsecd
echo 'Your are Anonymous great!'
echo 'Almost there...'
fi
}
HIDE_CHECK

echo '_______________________________________'
echo 'Exercise 4:'
echo ''
function OPPRESSED_TARGET()# the value OPPRESSED_TARGET are the details You will type 

{
echo 'What is the IP Adress of the SSH Target?'
read T_IP
echo 'What is the User Name of the SSh Target'
read T_USER
echo 'What is the Password Name of the SSh Target'
read T_PASS

echo 'Starting exeuting commands on the Target Machine'
echo ""
echo ""
echo ""
echo "🎯 Locking onto Target Data..."
cd
mkdir Data
cd Data

sshpass -p $T_PASS ssh -o StrictHostKeyChecking=no $T_USER@$T_IP "hostname -I | awk '{print $1}'"  > Your_IP.txt #Your IP.
echo ''
sshpass -p $T_PASS ssh -o StrictHostKeyChecking=no $T_USER@$T_IP 'geoiplookup $(curl -bashs -s ident.me)' > Correct_Country.txt #Correct Country.
echo ''
sshpass -p $T_PASS ssh -o StrictHostKeyChecking=no $T_USER@$T_IP "date" > Correct_Time.txt #Correct time of your server Location.
echo ''
echo ''
sshpass -p $T_PASS ssh -o StrictHostKeyChecking=no "$T_USER@$T_IP" 'whois $(curl -s ident.me)' > Whois_data.txt #Details of Your Vendor.
echo ''
echo ''
sshpass -p $T_PASS ssh -o StrictHostKeyChecking=no $T_USER@$T_IP "nmap $T_IP" > Nmap_data.txt  #open ports of the server.
echo ''
echo ''
sshpass -p $T_PASS ssh -o StrictHostKeyChecking=no $T_USER@$T_IP "whois espn.com" > whoisESPN.txt #Details of ESPN Vendor.

sshpass -p $T_PASS ssh -o StrictHostKeyChecking=no $T_USER@$T_IP "nmap 8.8.4.4" > Open_P.txt #Open ports of DNS server of Google.



echo '🚧 Valuable intelligence located and stored in the target directory. Action required to verify findings.🚧'

	
}
OPPRESSED_TARGET





