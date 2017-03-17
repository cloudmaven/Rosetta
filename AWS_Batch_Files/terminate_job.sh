#!/bin/bash
job_name=$1 #Don't enter index of jobs. Just the job name. For example if the Job name is XYZ_123, just enter XYZ.
job_id_start=1 #Initialise job_id_start
job_id_start=$2 #Enter the index of the job. For example if the job name is XYZ_123, enter 123.
job_id_end=${job_id_start} #Initialise job_id_end to job_id_start so that only one job is terminated if job_id_end is not specified.
job_id_end=$3 #If you want to terminate from XYZ_123 to XYZ_230, then enter 230 here. If left blank, only job with index of job_id_start will get terminated.
job_id=1 #Initialise job_id variable

for((i = job_id_start; i <= job_id_end ; i++))
        do
                job_id=$(cat ${job_name}_job_id_list.txt | grep -w ${job_name}_${i} | cut -f 1)
                aws batch terminate-job --job-id ${job_id} --reason "Wayward execution"
        done
exit