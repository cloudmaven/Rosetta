#!/bin/bash
job_name=$1 #The first argument is job_name which is prepended to all the silent files generated
job_queue_name=$2 
job_definition_name=$3
number_of_iterations=$4 
s3_bucket_name=$5
for((i=1; i <= number_of_iterations; i++))
	do
	    #The following line submits jobs to AWS batch and then records the job ID returned by AWS Batch to a file. It enables easy termination of jobs if the IDs are in a file.
		aws batch submit-job --job-name ${job_name}_${i} --job-queue ${job_queue_name}  --job-definition ${job_definition_name} --container-overrides vcpus=1,memory=750,command="./master.sh","${job_name}","${i}","${s3_bucket_name}" >> ${job_name}_job_id_list.txt
	done
exit