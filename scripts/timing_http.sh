#!/bin/bash
# TTFB: Time To First Byte
# ref: https://opswill.com/articles/curl-http-timing.html

Default_URL=https://www.baidu.com
URL=${1:-$Default_URL}

Result=`curl -o /dev/null -s $URL -w \
'
time_namelookup=%{time_namelookup}
time_connect=%{time_connect}
time_appconnect=%{time_appconnect}
time_redirect=%{time_redirect}
time_pretransfer=%{time_pretransfer}
time_starttransfer=%{time_starttransfer}
time_total=%{time_total}
'`

declare $Result

curl_timing() {
    for i in $Result
    do
        IFS='='
        printf "%-18s: %10s\n" $i
    done
}

stat_timing() {
    Result_TCP=`printf "%.6f" $(echo $time_connect - $time_namelookup | bc -l)`
    if [ `echo "$time_appconnect > $time_connect" | bc` -eq 1 ] ; then
        Result_TLS=`printf "%.6f" $(echo $time_appconnect - $time_connect | bc -l)`
        Result_TTFB=`printf "%.6f" $(echo $time_starttransfer - $time_appconnect | bc -l)`
    else
        Result_TLS=0
        Result_TTFB=`printf "%.6f" $(echo $time_starttransfer - $time_connect | bc -l)`
    fi
    Result_Server=`printf "%.6f" $(echo $time_starttransfer - $time_pretransfer | bc -l)`
    Result_Transfer=`printf "%.6f" $(echo $time_total - $time_starttransfer | bc -l)`

    printf "%18s: %.6f\n" "DNS Lookup" $time_namelookup
    printf "%18s: %.6f\n" "TCP Connection" $Result_TCP
    printf "%18s: %.6f\n" "TLS Handshake" $Result_TLS
    printf "%18s: %.6f\n" "Server Processing" $Result_Server
    printf "%18s: %.6f\n" "TTFB" $Result_TTFB
    printf "%18s: %.6f\n" "Content Transfer" $Result_Transfer
    printf "%18s: %.6f\n" "Total" $time_total
}

curl_timing
echo
stat_timing
