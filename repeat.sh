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


#-pix_fmt yuv420p -deinterlace -vf "scale=640:360" -vsync 1 -threads 0 -vcodec libx264 -r 29.970 -g 60 -sc_threshold 0 -b:v 1024k -bufsize 1216k -maxrate 1280k -preset medium -profile: v main -tune film -acodec aac -b:a 128k -ac 2 -ar 48000 -af

#ffmpeg -f dshow  -framerate 20 -i video=screen-capture-recorder -vf scale=1280:720 -vcodec libx264 -pix_fmt yuv420p -tune zerolatency -preset ultrafast -f mpegts udp://236.0.0.1:2000
