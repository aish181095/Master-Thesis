%%CURVE FITTING OPTIMISATION 


n=100;%number of iterations
x_values=zeros(12,n);%store parameter values
fval_values=zeros(1,n);%store the sum of square errors
exitflag_values=zeros(1,n);% number corresponding to the reason the solver halted the optimisation


%load the data from italy_data_phase.m file
covid_data=table2array(readtable('covid_data.csv'));%substitute the corresponding data file name
covid_data=covid_data/60e6;%scale the cases by the size of the population fo Italy.

tic;
%Initial Parameter values between 0 and 1
a = 0;
b = 1;
% create a pseudo-random uniform distribution of 100 initial guesses for the
% parameter values 
p_initial=((b-a).*rand(100,12) + a).';


%%Optimisation algroithm ( using parallelisation)
%Note:- Turn of parallelisation by subsituting 'parfor' for 'par' and the
%'UseParallel' option to false.

parfor i=1:n    

    %for fitting the before lockdown phase data bound the 4th (epsilon) and
    %the 7th(theta) position between [0,0.2] and [0.3,0.5] respectively.  
ub = [1;1;1;1;1;1;1;1;1;1;1;1];
lb = [0;0;0;0.0;0;0;0.0;0;0;0;0;0];
%Options set for patternsearch function
 options = optimoptions('patternsearch','Display','iter','MaxIter',5000,'MaxFunEvals',1000000,'TolMesh',1e-20,'TolCon',1e-20,...
    'PollMethod','GSSPositiveBasis2N',...
    'CompletePoll','on','CompleteSearch','on','Vectorized','off','UseParallel',true);
fun = @(p) sum(sum((Curvefit_model(p)-covid_data).^2));% Sum of square function 
[x_values(:,i),fval_values(i),exitflag_values(i)] = patternsearch(fun,p_initial(:,i),[],[],[],[],lb,ub,[],options);
end
toc;%timer 

%To save the data in '.mat' file.
%save optimised_values
