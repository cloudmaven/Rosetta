#!/bin/bash
threads=$(grep -c processor /proc/cpuinfo)
touch ${threads}_${Virtualisation_Type}_vCPUs_machine_benchmark_results.csv
echo "VM Type tested,Iteration Num,Number of threads in parallel,Current Thread Loaded, Time(s)" >> ${threads}_${Virtualisation_Type}_vCPUs_machine_benchmark_results.csv
for q in $(ls -1v *txt)
	do
		cat $q >> ${threads}_${Virtualisation_Type}_vCPUs_machine_benchmark_results.csv
	done

mkdir ${threads}_${Virtualisation_Type}_vCPUs_benchmark
mv *txt ${threads}_${Virtualisation_Type}_vCPUs_machine_benchmark_results.csv ${threads}_${Virtualisation_Type}_vCPUs_benchmark/
tar -cvzf ${threads}_${Virtualisation_Type}_vCPUs_benchmark.tar.gz ${threads}_${Virtualisation_Type}_vCPUs_benchmark
mpack -a ${threads}_${Virtualisation_Type}_vCPUs_benchmark.tar.gz -s "${threads}_${Virtualisation_Type}_vCPUs_Result" srihari.intelcentrino@gmail.com && sudo shutdown -h now
