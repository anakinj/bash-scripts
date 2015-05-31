#!/bin/sh
#Author: Joakim Antman (antmanj (at) gmail.com)

THINGSPEAK_APIKEY=$1
SPEEDTEST_SERVER="4549" #Helsinki, Elisa Oyj
RESULT_RAW=$(speedtest-cli --server $SPEEDTEST_SERVER --simple)
#DBGRESULT_RAW="ping: 20.031 Z download: 9.07 X upload: 0.80 Y"
rc=$?; if [ $rc != 0 ]; then exit $rc; fi

#AWK Version for the case when newlines would be preserved
#RES_PING=$(echo $RESULT_RAW | awk 'BEGIN {FS=" ";} { if($1 == "Ping:"){ print $2; } }')

RES_PING=$(echo $RESULT_RAW | cut -d' ' -f2)
RES_DOWNLOAD=$(echo $RESULT_RAW | cut -d' ' -f5)
RES_UPLOAD=$(echo $RESULT_RAW | cut -d' ' -f8)

echo "ping: $RES_PING download: $RES_DOWNLOAD upload: $RES_UPLOAD"

if [ "$THINGSPEAK_APIKEY" != "" ]
then
    echo "Pushing results to thinkspeak.com"
    curl -k --data "api_key=$THINGSPEAK_APIKEY&field1=$RES_PING&field2=$RES_DOWNLOAD&field3=$RES_UPLOAD" https://api.thingspeak.com/update
fi
