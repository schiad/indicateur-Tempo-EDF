#!/bin/bash

lpath="."
DATEJOURA=$(date +%Y-%m-%d --date="0 days")
DATEJOURL=$(date +%Y-%m-%d --date="1 days")

if [[ -f ./tmp ]]
then
	rm ./tmp
fi

if [[ -f "$lpath/results/$DATEJOURA.txt" ]];
then
	len=$(wc -c $lpath/results/$DATEJOURA.txt | cut -d' ' -f 1)
else
	len=0
fi
max=22

echo len $len

if (($len < $max))
then
	curl https://www.keskeces.fr/couleur-du-jour-edf-tempo.html --output ./tmp
	mva=$(cat tmp | grep -bo ">Couleur du Jour<" | cut -d: -f1)
	echo "mva $mva"
	#cat tmp | tail -c +$mva | head -c 80
	aujourdhui=$(cat tmp | tail -c +$mva | head -c 80 )
	echo "aujourdhui : $aujourdhui"
	rougea=$(echo $aujourdhui | grep -bo "Rouge" | cut -d: -f1)
	blanca=$(echo $aujourdhui | grep -bo "Blanc" | cut -d: -f1)
	bleua=$(echo  $aujourdhui | grep -bo "Bleu" | cut -d: -f1)
	echo "Aujourd\'hui Rouge : $rougea"
	echo "Aujourd\'hui Blanc : $blanca"
	echo "Aujourd\'hui Bleu  : $bleua"
	
	echo "wc Rougea : $(echo $rougea | wc -c)"
	echo "wc Blanca : $(echo $blanca | wc -c)"
	echo "wc Bleua  : $(echo $bleua  | wc -c)"
	echo -en "$DATEJOURA\t" > $lpath/results/$DATEJOURA.txt
	echo "TMP_ND" >> $lpath/results/$DATEJOURA.txt
	
	if (($(echo $bleua | wc -c) > 1))
	then
		echo -en "$DATEJOURA\t" > $lpath/results/$DATEJOURA.txt
		echo "TEMPO_BLEU" >> $lpath/results/$DATEJOURA.txt
		echo "Bleua detected"
	fi
	
	if (($(echo $blanca | wc -c) > 1))
	then
		echo -en "$DATEJOURA\t" > $lpath/results/$DATEJOURA.txt
		echo "TEMPO_BLANC" >> $lpath/results/$DATEJOURA.txt
		echo "Blanca detected"
	fi
	
	if (($(echo $rougea | wc -c) > 1))
	then
		echo -en "$DATEJOURA\t" > $lpath/results/$DATEJOURA.txt
		echo "TEMPO_ROUGE" >> $lpath/results/$DATEJOURA.txt
		echo "Rougea detected"
	fi

else
	echo "Aujourd\'hui fichier existe."
	cat $lpath/results/$DATEJOURA.txt
fi

if [[ -f "$lpath/results/$DATEJOURL.txt" ]];
then
	len=$(wc -c $lpath/results/$DATEJOURL.txt | cut -d' ' -f 1)
else
	len=0
fi
max=22

echo len $len

if (($len < $max))
then
	curl https://www.keskeces.fr/couleur-du-jour-edf-tempo.html --output ./tmp
	#(grep -bo Couleur du Lendemain)
	
	mvl=$(cat tmp | grep -bo ">Couleur du Lendemain<" | cut -d: -f1)
	echo "mvl $mvl"
	
	cat tmp | tail -c +$mvl | head -c 80
	lendemain=$(cat tmp | tail -c +$mvl | head -c 80)
	
	echo "lendemain : $lendemain"
	
	rougel=$(echo $lendemain | grep -bo "Rouge" | cut -d: -f1)
	blancl=$(echo $lendemain | grep -bo "Blanc" | cut -d: -f1)
	bleul=$(echo  $lendemain | grep -bo "Bleu" | cut -d: -f1)
	echo "Lendemain Rouge : $rougel"
	echo "Lendemain Blanc : $blancl"
	echo "lendemain Bleu : $bleul"
	
	echo "wc Rougel : $(echo $rougel | wc -c)"
	echo "wc Blancl : $(echo $blancl | wc -c)"
	echo "wc Bleul  : $(echo $bleul  | wc -c)"
	
	echo -en "$DATEJOURL\t" > $lpath/results/$DATEJOURL.txt
	echo "TMP_ND" >> $lpath/results/$DATEJOURL.txt
	
	if (($(echo $bleul | wc -c) > 1))
	then
		echo -en "$DATEJOURL\t" > $lpath/results/$DATEJOURL.txt
		echo "TEMPO_BLEU" >> $lpath/results/$DATEJOURL.txt
		echo "Bleul detected"
	fi
	
	if (($(echo $blancl | wc -c) > 1))
	then
		echo -en "$DATEJOURL\t" > $lpath/results/$DATEJOURL.txt
		echo "TEMPO_BLANC" >> $lpath/results/$DATEJOURL.txt
		echo "Blancl detected"
	fi
	
	if (($(echo $rougel | wc -c) > 1))
	then
		echo -en "$DATEJOURL\t" > $lpath/results/$DATEJOURL.txt
		echo "TEMPO_ROUGE" >> $lpath/results/$DATEJOURL.txt
		echo "Rougel detected"
	fi
else
	echo "Demain fichier existe."
	cat $lpath/results/$DATEJOURL.txt
fi

rm ./tmp
