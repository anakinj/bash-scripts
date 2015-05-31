#!/bin/sh

THINGSPEAK_APIKEY=""
RESULT_RAW=$(speedtest-cli --simple)

rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

RES_PING=$(echo $RESULT_RAW | awk 'BEGIN {FS=" ";} { if($1 == "Ping:"){ print $2; } }')
RES_DOWNLOAD=$(echo $RESULT_RAW | awk 'BEGIN {FS=" ";} { if($1 == "Download:"){ print $2; } }')
RES_UPLOAD=$(echo $RESULT_RAW | awk 'BEGIN {FS=" ";} { if($1 == "Upload:"){ print $2; } }')

echo "ping: $RES_PING download: $RES_DOWNLOAD upload: $RES_UPLOAD"

if [[ $THINGSPEAK_APIKEY != ""]]
then
    echo "Pushing results to thinkspeak.com"  
fi