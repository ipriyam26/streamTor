#! /bin/bash


# if [ ! -f "ins.txt" ]
# then
#   ./req.sh
# fi

read -p "What would you like to watch today : " Movie
search=$(curl -s --data-urlencode "q=$Movie" 'https://apibay.org/q.php' --compressed )
hash=$( echo $search | jq '.[0]' | jq -r '.info_hash')
seeds=$(echo $search | jq -r '.[0].seeders') 
if [ $seeds -lt 15 ]
then
    printf "Connection of Movie is a bit slow, you may experience buffering\n- Press P start it anyways\n  Press anything other key to quit :"
    read key
    [[ $key != "P"  ]] && exit
fi    
webtorrent --iina $hash



