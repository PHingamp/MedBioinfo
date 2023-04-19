#!/bin/bash
#
#SBATCH --partition=fast             # long, fast, etc.
#SBATCH --ntasks=1                   # nb of *tasks* to be run in // (usually 1), this task can be multithreaded (see cpus-per-task)
#SBATCH --nodes=1                    # nb of nodes to reserve for each task (usually 1)
#SBATCH --cpus-per-task=4            # nb of cpu (in fact cores) to reserve for each task /!\ job killed if commands below use more cores
#SBATCH --mem=250GB                  # amount of RAM to reserve for the tasks /!\ job killed if commands below use more RAM
#SBATCH --time=0-02:00               # maximal wall clock duration (D-HH:MM) /!\ job killed if commands below take more time than reservation
#SBATCH -o ./outputs/slurm.%A.%a.out   # standard output (STDOUT) redirected to these files (with Job ID and array ID in file names)
#SBATCH -e ./outputs/slurm.%A.%a.err   # standard error  (STDERR) redirected to these files (with Job ID and array ID in file names)
# /!\ Note that the ./outputs/ dir above needs to exist in the dir where script is submitted **prior** to submitting this script
#SBATCH --array=1-100                # 1-N: clone this script in an array of N tasks: $SLURM_ARRAY_TASK_ID will take the value of 1,2,...,N
#SBATCH --job-name=MedBioinfo        # name of the task as displayed in squeue & sacc, also encouraged as srun optional parameter
#SBATCH --mail-type END              # when to send an email notiification (END = when the whole sbatch array is finished)
#SBATCH --mail-user me@geemail.com

#################################################################
# Preparing work (cd to working dir, get hold of input data, convert/un-compress input data when needed etc.)
workdir="/shared/projects/form_2022_19/myname/ABCjob"
datadir="/shared/projects/form_2022_19/myname/seq_data"
accnum_file="/shared/projects/form_2022_19/myname/file_of_acc_nums.txt"

echo START: `date`

module load seqkit blast #as required

mkdir -p ${workdir}      # -p because it creates all required dir levels **and** doesn't throw an error if the dir exists :)
cd ${workdir}

# this extracts the item number $SLURM_ARRAY_TASK_ID from the file of accnums
accnum=$(sed -n "$SLURM_ARRAY_TASK_ID"p ${accnum_file})
input_file="${datadir}/${accnum}.fastq"
# alternatively, just extract the input file as the item number $SLURM_ARRAY_TASK_ID in the data dir listing
# this alternative is less handy since we don't get hold of the isolated "accnum", which is very handy to name the srun step below :)
# input_file=$(ls "${datadir}/*.fastq.gz" | sed -n ${SLURM_ARRAY_TASK_ID}p)

# if the command below can't cope with compressed input
srun gunzip "${input_file}.gz"

# because there are mutliple jobs running in // each output file needs to be made unique by post-fixing with $SLURM_ARRAY_TASK_ID and/or $accnum
output_file="${workdir}/ABCjob.${SLURM_ARRAY_TASK_ID}.${accnum}.out"

#################################################################
# Start work
srun --job-name=${accnum} some_abc_software --threads ${SLURM_CPUS_PER_TASK} --in ${input_file} --out ${output_file}

#################################################################
# Clean up (eg delete temp files, compress output, recompress input etc)
srun gzip ${input_file}
srun gzip ${output_file}
echo END: `date`