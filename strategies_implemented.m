%% Early lockdown implementation

parameters=[0.6824, 0.0003, 0.00057, 0.0003, 0.2, 0.247, 0.0010, 0.247, 0.0010, 0.5, 0.094, 0.0318, 0.0310, 0.0044,0.0318, 0.1378];
parameters(1)=0.0008;
parameters(2)=0.0008;
parameters(3)=0.2566;
model=SIDARTHE(parameters);

%% Early lockdown and mass testing policies
parameters=[0.6824, 0.0003, 0.00057, 0.0003, 0.2, 0.247, 0.0010, 0.247, 0.0010, 0.5, 0.094, 0.0318, 0.0310, 0.0044,0.0318, 0.1378];
parameters(1)=0.0008;
parameters(2)=0.0008;
parameters(3)=0.2566;
parameters(4)=1;
parameters(7)=1;
model=Sidarthe_analysis(parameters);

%% Mass testing policies
parameters=[0.6824, 0.0003, 0.00057, 0.0003, 0.2, 0.247, 0.0010, 0.247, 0.0010, 0.5, 0.094, 0.0318, 0.0310, 0.0044,0.0318, 0.1378];
parameters(4)=0.6;
model=Sidarthe_analysis(parameters);

%%
%scale up to the population size

for i=1:14
    model{i}=model{i}(:,1:10)*60e6;
end

%% Plot each strategy vs the actual cases 
population={'Diagnosed'; 'Recognised'; 'Threatened'; 'Healed'; 'Extinct'};
 n=15;
 day=74;
 colors_lines=linspecer(14);
 
 values=[3,5,6,7,8];
  for i=1:5
 
 subplot(2,3,i) ;
 %legend({'Actual data'},'Location','bestoutside')
 plot(1:day,model{1}(1:day,values(i)),'color',colors_lines(1,:),'linewidth',2)
 hold on
 plot(2:day,model{2}(1:day-1,values(i)),'color',colors_lines(2,:),'linewidth',2)
 hold on 
 plot(3:day,model{3}(1:day-2,values(i)),'color',colors_lines(3,:),'linewidth',2)
 hold on 
 plot(4:day,model{4}(1:day-3,values(i)),'color',colors_lines(4,:),'linewidth',2)
 hold on 
 plot(5:day,model{5}(1:day-4,values(i)),'color',colors_lines(5,:),'linewidth',2)
 hold on 
 plot(6:day,model{6}(1:day-5,values(i)),'color',colors_lines(6,:),'linewidth',2)
 hold on 
 plot(7:day,model{7}(1:day-6,values(i)),'color',colors_lines(7,:),'linewidth',2)
 hold on 
 plot(8:day,model{8}(1:day-7,values(i)),'color',colors_lines(8,:),'linewidth',2)
 hold on 
 plot(9:day,model{9}(1:day-8,values(i)),'color',colors_lines(9,:),'linewidth',2)
 hold on 
plot(10:day,model{10}(1:day-9,values(i)),'color',colors_lines(10,:),'linewidth',2)
 hold on 
 plot(11:day,model{11}(1:day-10,values(i)),'color',colors_lines(11,:),'linewidth',2)
 hold on 
plot(12:day,model{12}(1:day-11,values(i)),'color',colors_lines(12,:),'linewidth',2)
 hold on 
plot(13:day,model{13}(1:day-12,values(i)),'color',colors_lines(13,:),'linewidth',2)
 hold on 
 plot(14:day,model{14}(1:day-13,values(i)),'color',colors_lines(14,:),'linewidth',2)
 hold on 
scatter(1:day,italy_data(1:day,i),'filled','k')
 hold on 
  Legend=cell(n,1);
  Legend{15}=('Actual data');
 for iter=2:14
      Legend{1}=('After 1 day');
   Legend{iter}=strcat('After ',' ', num2str(iter),' days');
 end
  xlabel('Days') 
  ylabel('Cases')
  title(population{i});
  xlim([1 day])
 set(gca,'fontsize',16,'fontweight','bold','FontName', 'Times New Roman')
set(gcf,'color','white')
  grid on
 hold off
  end
% add a bit space to the figure
fig = gcf;
fig.Position(3) = fig.Position(3) + 500;
% add legend
Lgnd=legend(Legend);
Lgnd.Position(1) = 0.7;
Lgnd.Position(2) = -0.15;
%% Acquire immunity against COVID 19
% lowering worsening rate
parameters=[0.6824, 0.0003, 0.00057, 0.0003, 0.2, 0.247, 0.0010, 0.247, 0.0010, 0.5, 0.094, 0.0318, 0.0310, 0.0044,0.0318, 0.1378];
% for lockdown with lowering worsening rate
%these parameters are for lockdown implementation
parameters(1)=0.0008;
parameters(2)=0.0008;
parameters(3)=0.2544;
parameters_vac=repelem(parameters,14,1)';
worse_rate=linspace(0.001,0.000009,14);
for i=1:14
    parameters_vac(i,5)=worse_rate(i);% zeta and eta
    parameters_vac(i,10)=worse_rate(i);%mu
    parameters_vac(i,8)=worse_rate(i);%nu
  
end
%%
% increasing recovery rate
parameters=[0.6824, 0.0003, 0.00057, 0.0003, 0.2, 0.247, 0.0010, 0.247, 0.0010, 0.5, 0.094, 0.0318, 0.0310, 0.0044,0.0318, 0.1378];
% for lockdown with increasing recovery rate
%these parameters are for lockdown implementation
parameters(1)=0.0008;
parameters(2)=0.0008;
parameters(3)=0.2544;
parameters_vac=repelem(parameters,14,1)';
recov_rate=linspace(0.15,0.9,14);
for i=1:14
      parameters_vac(i,6)=recov_rate(i);%lambda and rho
       
      parameters_vac(i,9)=recov_rate(i);%kappa and xi
   
end
    
%% Propagate the acquired immunity model for all the parameter range

model=cell(14,1);
for j=1:14
    model{j}=Curvefit_model(parameters_vac(j,:));
end


%%
% scale up to population size
for i=1:14
    model{i}=model{i}(:,1:10)*60e6;
end
 
%% Plot worsening and recovery rate independently.
 population={'Diagnosed'; 'Recognised'; 'Threatened'; 'Healed'; 'Extinct'};
 n=15;
 day=74;
 colors_lines=linspecer(14);
 values=[3,5,6,7,8];
 
  for i=1:5
 
 subplot(2, 3,i) ;
 %legend({'Actual data'},'Location','bestoutside')
 plot(1:t,model{1}(1:day,values(i)),'color',colors_lines(1,:),'linewidth',2)
 hold on
 plot(1:t,model{2}(1:day,values(i)),'color',colors_lines(2,:),'linewidth',2)
 hold on 
 plot(1:t,model{3}(1:day,values(i)),'color',colors_lines(3,:),'linewidth',2)
 hold on 
 plot(1:t,model{4}(1:day,values(i)),'color',colors_lines(4,:),'linewidth',2)
 hold on 
 plot(1:t,model{5}(1:day,values(i)),'color',colors_lines(5,:),'linewidth',2)
 hold on 
 plot(1:t,model{6}(1:day,values(i)),'color',colors_lines(6,:),'linewidth',2)
 hold on 
 plot(1:t,model{7}(1:day,values(i)),'color',colors_lines(7,:),'linewidth',2)
 hold on 
 plot(1:t,model{8}(1:day,values(i)),'color',colors_lines(8,:),'linewidth',2)
 hold on 
 plot(1:t,model{9}(1:day,values(i)),'color',colors_lines(9,:),'linewidth',2)
 hold on 
plot(1:t,model{10}(1:day,values(i)),'color',colors_lines(10,:),'linewidth',2)
 hold on 
 plot(1:t,model{11}(1:day,values(i)),'color',colors_lines(11,:),'linewidth',2)
 hold on 
plot(1:t,model{12}(1:day,values(i)),'color',colors_lines(12,:),'linewidth',2)
 hold on 
plot(1:t,model{13}(1:day,values(i)),'color',colors_lines(13,:),'linewidth',2)
 hold on 
 plot(1:t,model{14}(1:day,values(i)),'color',colors_lines(14,:),'linewidth',2)
 hold on 
scatter(1:71,italy_lock_data(1:71,i),'filled','k')
 hold on 
  Legend=cell(n,1);
  Legend{15,1}=('Actual data');
  
 for iter=1:14     
  % Legend{iter,2}=strcat('\lambda,\rho,\kappa,\xi
  % =',num2str(recov_rate(iter)));%legend for recovery rate
  Legend{iter,1}=strcat('\zeta,\eta,\mu,\nu =',num2str(worse_rate(iter)));
  end
  xlabel('Days') 
  ylabel('Cases')
  title(population{i});
  xlim([1 71])
  set(gca,'fontsize',16,'fontweight','bold','FontName', 'Times New Roman')
set(gcf,'color','white')
  grid on
 hold off
  end
% add a bit space to the figure
fig = gcf;
fig.Position(1) = fig.Position(1) + 200;
% % add legend
Lgnd = legend(Legend{:,1});
Lgnd.Position(1) = 0.55;
Lgnd.Position(2) = -0.15;

