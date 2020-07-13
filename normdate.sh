#!/bin/bash

#Skrpyt normdate zamieniający oznaczenie miesiąca na trzyliteratoway skrót nazwy

monthNumToName()
{
#Przypisanie zmiennej 'month' opdowiedniej wartości

case $1 in
	1 ) month="sty"		;;	2 ) month="lut"		;;
	3 ) month="mar"		;;	4 ) month="kwi"		;;
	5 ) month="maj"		;;	6 ) month="cze"		;;
	7 ) month="lip"		;;	8 ) month="sie"		;;
	9 ) month="wrz"		;;	10) month="paź"		;;
	11) month="lis"		;;	12) month="gru"		;;  
	* ) echo "$0: Błędny numer miesiąca $1" >&2; exit 1
esac
return 0


}



if [ $# -eq 1 ] ; then #Uwzglednienie formatu ze znakami, jeśli liczba arugumentow równa się 1
	set -- $(echo $1 | sed 's/[\/\-]/ /g')  #set -- znosi to, że komenda będzie interpretować "-"  jako dodatkowe opcje komendy
fi


if [ $# -ne 3 ] ; then  #czy ilośc argumentów nie równa się 3
	echo "Użycie: $0 dzień miesiąc rok" >&2
	echo "Typowe formaty: '3 sierpnia 2002, '3 8 2002'" >&2
	exit 1
fi

#sprawdzenie czy data jest dobrze wpisana 
if [ $1 -eq 0 ] || [ $1 -gt 31 ] ; then #czy pierwczy argument lub pierwszy argument jest większy niż 31
	echo "$0: Błędna data" >&2; exit 1
fi

if [ $3 -le 99 ] ; then #czy 3 argument jest mniejszy czy równy  
	echo "$0: rok musi być liczbą czterocyfrową." >&2; exit 1
fi

#Czy miesiac jest podany w postaci liczby
if [ -z $(echo $2| sed 's/[[:digit:]]//g') ]; then  #czy zamiana ciagu znaków z cyfr za pomocą sed jest pusty 
	monthNumToName $2
else
#Normalizacja nazwy miesiąca: tylko trzy pierwsze litery
month="$(echo $2| cut -c1-3 | tr '[:upper:]' '[:lower:]')" #jesli nie pusty to wyciecie 3 pierwszych liter miesiaca 
fi							   # zamiana wielkośći liter z dużcyh na małe

echo $1 $month $3

exit 0



