#!bin/bash
#2017-06-04
#Extract MP3 from MKV
#$1: source address 
#$2: destination address 

src=`ls  $1 |grep .m`
cd $1
index=0
for file in $src
do    
    let 'index=index+1'
    first_name=`ls $file |cut -d '.' -f 1` # 去除后缀
    iconv -f gbk -t utf-8 $file |tee temp.m
    ptrash $file
    mv temp.m $file
    echo ''
    echo $index: $file' converted to utf-8'
    #    mencoder -oac mp3lame -ovc copy -of rawaudio $file -o \
    #        ../$2/$first_name.mp3 -quiet
done
#echo 'Successfully extract' $index 'MP3 files from MKV files.'
