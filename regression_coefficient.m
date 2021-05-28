
%% REGRESSION COEFFICIENT
%substitute the optimised parameters for each phase
fitted_model=Curvefit_model(parameters);

%set up empty arrays
num_covid=zeros(32,5);
denom_covid=zeros(32,5);
R2=zeros(1,5);%store the R2 value
% calculate the Regression co-efficient

for i=1:5
num_covid(:,i)=(lockdown_italy_2(:,i)-fitted_model(:,i));
denom_covid(:,i)=(lockdown_italy_2(:,i)-mean(lockdown_italy_2(:,i)));

R2(i) = 1 - sum(num_covid(:,i).^2)/sum(denom_covid(:,i).^2);
end






square(covid_data(:,2)-mean(covid_data(:,2)))