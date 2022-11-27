#!/bin/bash
# URL checker who work like ping with curl
# THIS SCRIPT WORK BUT I NEED TO OPTIMISE IT AND CHECK SOME USER INPUT ERROR
url=$1;
option=$2;

#Check function
function check_host()
{
	curl -m 2 $url > /dev/null 2>&1
	code=$?
	if [ $code -eq 0 ]
	 then
  	 echo "$url is online!"
	elif [ $code -eq 6 ]
 	 then
  	 echo "Error: Could not resolve host. The given remote host was not resolved."
	elif [ $code -eq 2 ]
 	 then
  	 echo "Error: Failed to initialize. This is mostly an internal error or a problem with the libcurl installation or system libcurl runs in."
	elif [ $code -eq 28 ]
 	then
  	 echo "Error: Operation timeout. The specified time-out period was reached according to the conditions. curl offers several timeouts, and this exit code tells one of those timeout limits were reached. Extend the timeout or try changing something else that allows curl to finish its operation faster. Often, this happens due to network and remote server situations that you cannot affect locally."
	elif [ $code -eq 7 ]
 	then
  	 echo "Error: Failed to connect to host. curl managed to get an IP address to the machine and it tried to setup a TCP connection to the host but failed. This can be because you have specified the wrong port number, entered the wrong host name, the wrong protocol or perhaps because there is a firewall or another network equipment in between that blocks the traffic from getting through."
	else
 	 echo "Error:  $code"
	fi
}

function show_usage()
{
    echo "Usage: churl [host (ip or url)] [parameters]]"
	echo ""
    echo "Options:"
    echo " -n 0-9      | Number of requests to send"
    echo " -u          | Send unlimited requests  (Need CTRL + C for stop process)"
    echo " -help       | Show this help"
return 0
}



if [[ "$@" == *"-help"* ]]
then
    show_usage
elif [[ "$2" == "-n" ]]
then
	i=0
	while [ $i -ne $3 ]
	 do
		check_host
		sleep 1
		i=$((i+1))
	done
elif [[ "$2" == "-u" ]]
then
	while true
	 do
		check_host
		sleep 1
	 done
else
    check_host
fi
exit
