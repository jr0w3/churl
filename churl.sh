#!/bin/bash
# URL checker who work like ping with curl
# 
url=$1;
option=$2;

#Check function
Check()
{
	curl -m 2 $url > /dev/null 2>&1
	code=$?
	if [ $code -eq 0 ]
	 then
  	 echo "La cible $url est en ligne!"
	elif [ $code -eq 6 ]
 	 then
  	 echo "Erreur: L'adresse du serveur donné n'a pas pu être résolue. Soit le nom d'hôte donné est tout simplement faux, soit le serveur DNS est mal configuré."
	elif [ $code -eq 2 ]
 	 then
  	 echo "Erreur: Échec de l'initialisation. Il s'agit principalement d'une erreur interne ou d'un problème avec l'installation de libcurl ou le système dans lequel libcurl s'exécute.."
	elif [ $code -eq 28 ]
 	then
  	 echo "Erreur: Délais de la requête expirée. La cible n'a pas répondu dans le temps imparti."
	elif [ $code -eq 7 ]
 	then
  	 echo "Erreur: Échec de la connexion à l'hôte $url. Curl a réussi à obtenir une adresse IP sur la machine et a essayé de configurer une connexion TCP à l'hôte mais a échoué."
	else
 	 echo "Erreur:  $code"
	fi
}

function show_usage (){
    echo "###############"
    echo "# CHURL by jrowe #"
    echo "###############"
    echo "Utilisation: churl [IP/URL options [parameters]]"
    echo " "
    echo "Options:"
    echo " -n 0-9      | Nombre de requètes à envoyer"
    echo " -i          | Envoyer des requètes sans limite  (CTRL + C pour arrêter)"
    echo " churl -h    | Afficher l'aide"
return 0
}


if [[ "$2" == "--help" ]] || [[ "$2" == "-h" ]] || [[ "$1" == "-h" ]] || [[ "$1" == "-h" ]];then
    show_usage
elif [[ "$2" == "-n" ]];then
i=0
while [ $i -ne $3 ]
 do
    Check
    sleep 1
    i=$((i+1))
done
elif [[ "$2" == "-i" ]];then
while true
 do
    Check
    sleep 1
 done
else
    Check
fi
exit
