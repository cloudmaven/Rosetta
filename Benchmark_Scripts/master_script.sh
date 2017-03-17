#!/bin/bash
threads=$(grep -c processor /proc/cpuinfo)
Virtualisation_Type=$(sudo dmidecode | grep domU | cut -c 15-17 | xargs )
for k in $(seq 1 10)
	do
		for t in $(seq 1 $threads)
			do
				for i in $(seq 1 $t)
					do
						source worker_script.sh &
					done
					wait
			done
	done
echo "Benchmark done"
source aggregation.sh
exit
