#!/usr/bin/env bash

export SHELL=/bin/bash
export PATH=/usr/local/sbain:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

echo Enter s3 bucket name : 
read bucket_name
echo Enter absolute path for local dorectory to backuo : 
read local_directory
echo Enter absolute path for local directory tos tore failed objects : 
read backup_failed


for files in $local_directory/*; do
	echo "UPLOADING : "
	echo $files
        aws s3 cp $files s3://$bucket_name/${files##/*/}>&output.txt
        RS=`cat output.txt`
        STR='upload: failed: while pushing obj'
        SUB='upload:'
        if [[ "$RS" == *"$SUB"* ]]; then
                echo "success :" ${audio_files}
                rm ${files}
        else
                echo "failed"
                mv ${files} $backup_failed
        fi
done


