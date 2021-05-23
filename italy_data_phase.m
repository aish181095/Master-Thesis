%%Italy data obtained from https://github.com/pcm-dpc/COVID-19.git. Load
%%the file mentioned in the first line of code. 

%Italy data
italy_complete_data=readtable('dpc-covid19-ita-andamento-nazionale.csv');
% Italian population
popolazione=60e6;

% Data 24 February - 7 May (74 days):
% Total Cases
confirmed_cases=table2array(italy_complete_data(:,14)); % D+R+T+E+H_diagnosticati

% Deaths
death_cases=table2array(italy_complete_data(:,11));% E

% Recovered
recovered_cases=table2array(italy_complete_data(:,10));% H_diagnosticati

% Currently Positive
positive_cases=table2array(italy_complete_data(:,7));  % D+R+T

% Currently positive: isolated at home
isolated_home=table2array(italy_complete_data(:,6)); %D

% Currently positive: hospitalised
hospitalised_cases=table2array(italy_complete_data(:,5));% R

% Currently positive: ICU
icu_cases=table2array(italy_complete_data(:,4)); %T

%combining the above vectors
combined_table= [isolated_home hospitalised_cases icu_cases recovered_cases death_cases];
colnames={'diagnosed','recognised','threatened','healing','extinct'};%renaming the columns
combined_table=array2table(combined_table,'VariableNames',colnames);%convert the array to table


%%
%before lockdown phase data
covid_data=table2array(combined_table(1:14,:));%14 days

%%
%14 days after lockdown 
lockdown_italy=table2array(combined_table(14:27,:));%14 days

%%
%28 days after lockdown
lockdown_italy_1=table2array(combined_table(27:41,:));%14 days

%%
%32 days after lockdown
lockdown_italy_1=table2array(combined_table(41:73,:));%32 days