#!/bin/bash
START_TIME=$SECONDS
static_build_stripped_down/build/src/release/linux/4.4/64/x86/gcc/5.4/static/rosetta_scripts.static.linuxgccrelease -in:file:s ~/blueprint_aws_test/rsmn.pdb -parser:protocol ~/blueprint_aws_test/input.xml -nstruct 1 -out:file:silent Output_${t}_${k}_${i}.silent -out:file:silent_struct_type binary -beta_nov15 -run:constant_seed -mute all
ELAPSED_TIME=$(($SECONDS - $START_TIME))
echo $Virtualisation_Type","$k","$t","$i","$ELAPSED_TIME >> ${k}_${t}_${i}.txt
exit
