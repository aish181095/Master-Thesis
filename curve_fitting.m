%%
%%
clear all
close all
clc
% *LOCKDOWN FOR ITALY*
%%
%Load the data
lockdown_italy=table2array( readtable('lockdown_italy_data.csv'));
days=(1:58)';%days 
lockdown_italy(:,1)=lockdown_italy(:,1)./10000;%scaling of the firct column

%%

%set random parameters values 
p_initial=rand(16,50);
p_initial_1=rand(6,50);%for 

%%
%optimisation loop for all parameters  
lb = repmat(0,16,1); %lower boundary 
ub = repmat(100,16,1); %upper boundary 
for i =1:50%for two randomised parameter value
options=optimoptions('lsqcurvefit','Display','iter','MaxIter',200,'MaxFunEvals',10000,'TolFun',1e-10,'TolX',1e-08,'UseParallel',true);
% optimset, the name is MaxIter
[xfitted(i,1:16),resnorm(i)] = lsqcurvefit(@LSCostFunction,p_initial(:,i)',days,lockdown_italy,lb,ub,options);%objective function
 end
%%
%optimisation loop for certain constant parameters 
lb = repmat(0,6,1);
ub = repmat(100,6,1);
for i =1:50%for two randomised parameter value
options=optimoptions('lsqcurvefit','Display','iter','MaxIter',20,'MaxFunEvals',10000,'TolFun',1e-10,'TolX',1e-08,'UseParallel',true);
% optimset, the name is MaxIter
[xfitted(i,1:16),resnorm(i)] = lsqcurvefit(@LSCostFunction,p_initial_1(:,i)',days,lockdown_italy,lb,ub,options);%objective function
 end
%%
%store values in a cell array
n=50;
Covid_matrix=cell(n,1);
for k = 1 : n
    Covid_matrix{k}=LSCostFunction(xfitted(k,:),days);
end
%%
%scale back the first column 
for j=1:50
Covid_matrix{j,1}(:,1)=Covid_matrix{j,1}(:,1).*10000;
end
lockdown_italy(:,1)=lockdown_italy(:,1).*10000;
%%
%generates plots for the eight compartment (columns )
population={'Suceptible';'Infected' ;'Diagnosed'; 'Ailing'; 'Recognised'; 'Threatened'; 'Healing'; 'Extinct'};
 n=50;
 colors_lines=linspecer(n);
 %population={'Suceptible';'Infected' ;'Diagnosed'; 'Ailing'; 'Recognised'};
 for k= 1:8
     covid_plots=figure(k);
for j=1:n
   plot(days,Covid_matrix{j,1}(:,k),'color',colors_lines(j,:),'linewidth',3);hold on
   Legend=cell(n,1);
 for iter=1:n
   Legend{iter}=strcat('Iteration', num2str(iter));
 end
 legend(Legend,'Location','bestoutside')
 end
   hold on
   scatter(days, lockdown_italy(:,k),'b','filled')
   title(population{k});
   xlabel('Days') 
   ylabel('Cases')
   grid on
   hold off
   saveas(covid_plots,population{k},'png');
 end