# Init investigation directory
mkdir Lucky_Duck_Investigations
mkdir Lucky_Duck_Investigations/Roulette_Loss_Investigation
mkdir Lucky_Duck_Investigations/Roulette_Loss_Investigation/Player_Analysis
mkdir Lucky_Duck_Investigations/Roulette_Loss_Investigation/Dealer_Analysis
mkdir Lucky_Duck_Investigations/Roulette_Loss_Investigation/Player_Dealer_Correlation

# Create notes
touch Lucky_Duck_Investigations/Roulette_Loss_Investigation/Player_Analysis/Notes_Player_Analysis
touch Lucky_Duck_Investigations/Roulette_Loss_Investigation/Dealer_Analysis/Notes_Dealer_Analysis
touch Lucky_Duck_Investigations/Roulette_Loss_Investigation/Player_Dealer_Correlation/Notes_Dealer_Correlation

# Download Casino data
wget "https://tinyurl.com/3-HW-setup-evidence" && chmod +x ./3-HW-setup-evidence && ./3-HW-setup-evidence

# Find and copy dealer schedules
find Dealer_Schedules_0310/ -type f -iname '*0310*' | xargs cp -t Lucky_Duck_Investigations/Roulette_Loss_Investigation/Dealer_Analysis
find Dealer_Schedules_0310/ -type f -iname '*0312*' | xargs cp -t Lucky_Duck_Investigations/Roulette_Loss_Investigation/Dealer_Analysis
find Dealer_Schedules_0310/ -type f -iname '*0315*' | xargs cp -t Lucky_Duck_Investigations/Roulette_Loss_Investigation/Dealer_Analysis

# Find and copy player wins and losses
find Roulette_Player_WinLoss_0310/ -type f -iname '*0310*' | xargs cp -t Lucky_Duck_Investigations/Roulette_Loss_Investigation/Player_Analysis
find Roulette_Player_WinLoss_0310/ -type f -iname '*0312*' | xargs cp -t Lucky_Duck_Investigations/Roulette_Loss_Investigation/Player_Analysis
find Roulette_Player_WinLoss_0310/ -type f -iname '*0315*' | xargs cp -t Lucky_Duck_Investigations/Roulette_Loss_Investigation/Player_Analysis

cd Lucky_Duck_Investigations/Roulette_Loss_Investigation/Player_Analysis
grep -i "-" *win_loss* > Roulette_Losses

# Times
sed 's/00:00 AM/AM/' Roulette_Losses | sed 's/00:00 PM/PM/' | sed 's/, /,/' | sed 's/ ,/,/' | sed 's/,  /,/' | sed 's/ , /,/' > temp
cat temp > Roulette_Losses
rm temp
awk '{print $1}' Roulette_Losses > Notes_Player_Analysis
cat Notes_Player_Analysis > Loss_Hours

# Lookup Mylie Schmidt
grep -i 'Mylie Schmidt' Roulette_Losses | wc -l | awk "{print $1 ' instances of Mylie Schmidt'}"

# Find bad dealer
cd ../Dealer_Analysis
cp ../Player_Analysis/Loss_Hours > Loss_Hours
echo 'LOSS HOURS: '
cat Loss_Hours
sh ../../../roulette_dealer_finder_by_time.sh 05 AM 031 >> Dealers_working_during_losses
sh ../../../roulette_dealer_finder_by_time.sh 08 AM 031 >> Dealers_working_during_losses
sh ../../../roulette_dealer_finder_by_time.sh 02 PM 031 >> Dealers_working_during_losses
sh ../../../roulette_dealer_finder_by_time.sh 08 PM 031 >> Dealers_working_during_losses
sh ../../../roulette_dealer_finder_by_time.sh 11 PM 031 >> Dealers_working_during_losses

awk '{print $5 $6}' Dealers_working_during_losses | head -n 1 > Notes_Dealer_Analysis
head -n 1 Notes_Dealer_Analysis | wc -l Dealers_working_during_losses >> Notes_Dealer_Analysis

