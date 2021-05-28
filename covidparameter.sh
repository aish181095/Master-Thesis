#!/usr/local_rwth/bin/zsh
 
### Job name
#SBATCH --job-name=Example_covid_parallel_matlab_job
 
### File / path which STDOUT will be written to, %J is the job ID
#SBATCH --output=Ex_par_covid_matlab.%J
 
### Request the time you need for execution. The full format is D-HH:MM:SS
### You must at least specify minutes or days and hours and may add or
### leave out any other parameters
#SBATCH --time=1-23:00:00
  
### Request the memory you need for your job. You can specify this
### in either MB (1024M) or GB (4G).
#SBATCH --mem-per-cpu=128G

# Ensure you use DKE resources
#SBATCH -A um_dke
 
### Change to the work directory, if not in submit directory
#cd $home/jf762744/fitting_code.m/is
 
### Load the required modules
module load MISC
module load matlab/2019b
 
 
### start non-interactive batch job
matlab -nodisplay -nodesktop -nosplash -logfile job.$Ex_par_covid_matlab.%J.txt <<EOF
cl = parcluster('local')
tmpdirforpool = tempname
mkdir(tmpdirforpool)
cl.JobStorageLocation = tmpdirforpool
cl.NumWorkers = str2num(getenv('SLURM_NTASKS'))
parpool(cl,str2num(getenv('SLURM_NTASKS')))
cl; poolobj = gcp;
disp(['%-- parpool working with (' num2str(poolobj.NumWorkers) ') workers --%']);
disp(['%-- parpool working here (' poolobj.Cluster.JobStorageLocation ')  --%']);
% now run the 'dot-m-file.m' script
fitting_code;
delete(gcp)
quit();
EOF
