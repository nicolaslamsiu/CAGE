#!/bin/bash
#SBATCH --qos=shared
#SBATCH --time=12:00:00
#SBATCH --constraint=haswell
#SBATCH --account=m2676
#SBATCH --export=HDF5_USE_FILE_LOCKING=FALSE
#SBATCH --image=legendexp/legend-base:latest
#SBATCH --chdir=/global/project/projectdirs/legend/software/CAGE/processing
#SBATCH --output=/global/project/projectdirs/legend/software/CAGE/processing/logs/cori-%j.txt
#SBATCH --mail-type=end,fail
#SBATCH --mail-user=wisecg@uw.edu

echo "Job Start:"
date
echo "Node(s):  "$SLURM_JOB_NODELIST
echo "Job ID:  "$SLURM_JOB_ID

if [ -n "$SHIFTER_RUNTIME" ]; then
  echo "Shifter image active."
  echo "pwd: "`pwd`
  echo "gcc: "$CC
  echo "g++:"$CXX
  echo "Python:"`python --version`
  echo "ROOT:"`root-config --version`
fi

# shifter python processing.py -q 'cycle>438' --d2r --r2d -o -v

# run everything
shifter python processing.py -q 'cycle>1' --d2r --r2d -o -v

# This runs whatever we pass to it (maybe from python)
# echo "${@}"
# ${@}

# note, to check resource usage while this job is running you can do:
# ssh_job <JobID>

echo "Job Complete:"
date