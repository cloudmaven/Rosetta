#!/bin/bash
job_name=$1  #Argument 1: Job name. For example 'Alanine_Job''
file_name_serial_number=$2 #Argument 2: Index of jobs. For example if file_name_serial_number was 16, then this would be the 16th job that would be spun up.
s3_bucket_name=$3 #Argument 3: Takes in S3 bucket name to send the silent files to the bucket. Example 'rosetta-storage'
current_dir=$(pwd) 

source ${current_dir}/background_silent_file_scanner.sh & #Start the background_silent_file_scanner in the background.
background=$(jobs -p) #Stores the PID of the background_silent_file_scanner process that is running in the background.
START_TIME=$SECONDS #Record the start time for loggin of runtime.
${current_dir}/RFEB_GCC_NOMARCH/simple_cycpep_predict.static.linuxgccrelease -database ${current_dir}/database -nstruct 10 -out:file:silent_struct_type binary -out:file:silent ${current_dir}/${job_name}_${file_name_serial_number}.silent -beta_nov15 -mute all @${current_dir}/flags_10mer_enumerate_batch #The rosetta program with arguments. Ensure that all the paths are correct. Do a sample run before spinning up a huge job.
ELAPSED_TIME=$(($SECONDS - $START_TIME)) #Get the current time and subtract START_TIME time from it to get the run time.


echo $ELAPSED_TIME >> ${current_dir}/${job_name}_${file_name_serial_number}_runtime.txt #Write the run time to a file.
aws s3 cp ${current_dir}/${job_name}_${file_name_serial_number}.silent s3://${s3_bucket_name}/${job_name}/ #Upload .silent file to S3 Bucket.
aws s3 cp ${current_dir}/${job_name}_${file_name_serial_number}_runtime.txt s3://${s3_bucket_name}/${job_name}/logs/ #Upload the run time file to logs folder in S3.
kill ${background} #Kill background_silent_file_scanner process that was running in the background

echo "done"
exit