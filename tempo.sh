#!/bin/bash
#	 https://particulier.edf.fr/bin/edf_rc/servlets/ejptemponew?Date_a_remonter=2020-12-24&TypeAlerte=TEMPO

function tempo {
	DATEJOUR=$(date +%Y-%m-%d --date="$1 days")
	adresse="https://particulier.edf.fr/bin/edf_rc/servlets/ejptemponew?Date_a_remonter="
	finadresse="&TypeAlerte=TEMPO"
	adresse=${adresse}${DATEJOUR}${finadresse}

	if [[ -f "./results/$DATEJOUR.txt" ]];
	then
		len=$(wc -c ./results/$DATEJOUR.txt | cut -d' ' -f 1)
	else
		len=0
	fi
	max=15

	echo "wc $len"
	#echo $adresse
	if (($len < $max))
	then
		wget -O site.txt $adresse 2>> ./tempo.log
	
		#echo RechercheJour
		coul_J=$(grep -Po '(?<="JourJ":{"Tempo":")[^"]+(?=")' site.txt)
		#coul_J1=$(grep -Po '(?<="JourJ1":{"Tempo":")[^"]+(?=")' site.txt)
		if [[ ! -d ./results ]];
		then
			mkdir ./results
		fi
		echo -en "$DATEJOUR\t"
		echo -en "$DATEJOUR\t" > ./results/$DATEJOUR.txt
	
		echo $coul_J
		echo $coul_J >> ./results/$DATEJOUR.txt
		#echo $coul_J1
	else
		echo "$DATEJOUR exists."
	fi
}

main () {
	if [ $# -eq 0 ]
	then
		for i in $(seq -10 1)
		do
			tempo $i
		done
	else
		tempo $1
	fi

	if [[ -f site.txt ]];
	then
		rm site.txt
	fi
}

main $*
