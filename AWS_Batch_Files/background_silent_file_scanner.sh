#!/bin/bash

for((;;))
        do
                aws s3 cp ${current_dir}/${job_name}_${file_name_serial_number}.silent s3://${s3_bucket_name}/${job_name}/
                sleep 200
done
exit