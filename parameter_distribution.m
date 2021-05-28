%% PARAMETER DISTRIBUTION USING BOOTSTRAP SAMPLING

%Load the data
covid_data=table2array(readtable('lockdown_italy_2.csv'));%load corresponding csv file
covid_data=covid_data/60e6;%scale by population

%substitute the value of the best fit parameters(obtained from fitting_code.m)
parameters= zeros(1,12);
parameters(1)=0.6835;
parameters(2)=3.14e-04;
parameters(3)=9.554e-04;
parameters(4)=0.2;
parameters(5)=0.2478;
parameters(6)=2.96e-04;
parameters(7)=0.5;
parameters(8)=0.0858;
parameters(9)=0.0296;
parameters(10)=0.0381;
parameters(11)=0.0316;
parameters(12)=0.1387;

% Generate NBOOT resamplings of the x-y pairs
M=100;


Phatss_values=zeros(M,12); % vector that will store parameter estimates from each realization
SSEs_values=zeros(M,1); % SSE for each realization
curves=[]; 

% generate each of the M realizations
%Note: Parallelisation used. To turn off, change 'parfor' to 'for'.
parfor realization=1:M
    
    % bootstrap realization is generated
    
    covid_syn_pop=zeros(length(covid_data),5);%create an empty vector for the data
        
    %yirData(1)=F(1);
    
    covid_data_pop=covid_data*60e6;%re-scale to population
    covid_syn_pop=poissrnd(covid_data_pop,14,5);%create the synthetic data based on the poisson error distribution
    covid_syn=covid_syn_pop/60e6;%scale by population
    
    % store realiation of the epidemic curve
    curves=[curves;covid_syn];

    
    % Estimate parameters from bootstrap realization
    
   
    
    hold on
    %upper and lower bound for parameter values
ub = [1;1;1;0.2;1;1;0.5;1;1;1;1;1];
lb = [0;0;0;0;0;0;0.3;0;0;0;0;0];
        
   options = optimoptions('patternsearch','Display','iter','MaxIter',5000,'MaxFunEvals',1000000,'TolMesh',1e-20,'TolCon',1e-20,...
     'PollMethod','GSSPositiveBasis2N',...
    'CompletePoll','on','CompleteSearch','on','Vectorized','off','UseParallel',true);
    fun = @(p) sum(sum((LSCostFunction_1(p)-covid_syn).^2));%%SSE equation
   [xfitted_dist,fval_dist] = patternsearch(fun,parameters,[],[],[],[],lb,ub,[],options);
    
    % Stores estimated parameters for each realization of a total of M realizations
    Phatss_values(realization,:)=xfitted_dist; 
    % Stores error for each realization of a total of M realizations
    SSEs_values(realization,:)=fval_dist;
    
end

%save the '.mat' file
save param_dist


%%
%Estimate the 97.5% confidence intervals for the parameter distributions

%rearrange the parameters.
Phatss_values=Phatss_values(:,[1,2,3,2,4,5,6,5,6,7,8,9,10,11,9,12]);

n=16; % number of model parameters
%create empty arrays.
SEM=zeros(1,n); %Standard Error of Mean
ts=zeros(n,2);  % z-scores
CI=zeros(n,2);   %confidence intervals
mean_param_values=zeros(1,n); %mean of the distribution
for i =1:n
mean_param_values(i)=mean(Phatss_values(:,i));    
SEM(i) = std(Phatss_values(:,i))/sqrt(length(Phatss_values));               % Standard Error
ts(i,:) = tinv([0.025  0.975],length(Phatss_values)-1);      % z-Score
CI(i,:) = mean(Phatss_values(:,i)) + ts(i,:)*SEM(i); %Confidence Interval   
end
