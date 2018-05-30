#!/bin/bash

video=$(ls *.ts)

sysctl net.ipv4.conf.default.rp_filter=0
sysctl net.ipv4.conf.all.rp_filter=0
sysctl net.ipv4.conf.eth0.force_igmp_version=2

for i in $video; do videos+="$i|"; done
	
	ffmpeg -re -stream_loop -1 -i "concat:$videos" -vcodec mpeg2video -acodec mp2 -f mpegts "udp://239.0.3.10:10000?ttl=4&pkt_size=1316" > /dev/null
  
  # EXAMPLES
  #ffmpeg -re -stream_loop -1 -i "concat:$videos" -vcodec copy -acodec copy -f mpegts udp://239.0.3.10:10000[ttl=7]
  #ffmpeg -re -i $i -vcodec copy -acodec copy -f mpegts "udp://235.0.0.1:10000" > /dev/null
  #ffmpeg -re -i $i -vcodec copy -f mpegts udp://235.0.0.1:10000[ttl=1,buffer_size=2097157] > /dev/null
  #ffmpeg -re -i $i -vcodec copy -f mpegts udp://235.0.0.1:10000
  #ffmpeg -re -i [source] -vcodec mpeg2video -s 720x576 -r 25 -b:v 2M -acodec mp2 -ac 2 -b:a 192k -f mpegts udp://239.253.253.4:1234?pkt_size=1316
