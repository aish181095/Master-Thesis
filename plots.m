%% Model fit plots for the four phases

%select the best fit parameters 
%fval_values obtained from fitting_code.m script
min_error=find(fval_values==min(fval_values));
parameters_no_lock=x_values(min_error);

%similarly perform the same for the other phases as well.

%%
% store the model values for each phase
fit=Curvefit_model(parameters_no_lock)*60e6;%scale up by population size
fit_phase_1=Curvefit_model(parameters_lock_1)*60e6;%scale up by population size
fit_phase_2=Curvefit_model(parameters_lock_2)*60e6;%scale up by population size
fit_phase_all=Curvefit_model(parameters_lock_last)*60e6;%scale up by population size



%%
ImageFontSize=18;
%set time period (days)
t=1:14;
t1=1:32;

%figure(2)
figure(10)
subplot(2,3,1)
scatter(t,covid_data(:,1),'filled','bo')
hold on
scatter(t,covid_data(:,2),'filled','rs')
hold on
scatter(t,covid_data(:,3),'p','MarkerFaceColor',[0.9290 0.6940 0.1250],'MarkerEdgeColor',[0.9290 0.6940 0.1250])
hold on
scatter(t,covid_data(:,4),'filled','kh')
hold on
scatter(t,covid_data(:,5),'filled','m^')
hold on
plot(t,fit(:,3),'LineWidth',2.0,'Color','b')
hold on
plot(t,fit(:,5),'LineWidth',2.0,'Color','r')
hold on
plot(t,fit(:,6),'LineWidth',2.0,'Color',[0.9290 0.6940 0.1250])
hold on
plot(t,fit(:,7),'LineWidth',2.0,'Color','k')
hold on
plot(t,fit(:,8),'LineWidth',2.0,'Color','m')
xlim([t(1) t(end)]);
ylabel('Cases','Position',[-1.5 2500],'fontsize',ImageFontSize);
xlabel('Days','fontsize',ImageFontSize);
title('(a)','position',[-2,5000],'FontSize',16);
set(gca,'fontsize',16,'fontweight','bold','FontName', 'Times New Roman')
set(gcf,'color','white')
grid on

subplot(2,3,2)
scatter(t,lockdown_italy(:,1),'filled','bo')
hold on
scatter(t,lockdown_italy(:,2),'filled','rs')
hold on
scatter(t,lockdown_italy(:,3),'p','MarkerFaceColor',[0.9290 0.6940 0.1250],'MarkerEdgeColor',[0.9290 0.6940 0.1250])
hold on
scatter(t,lockdown_italy(:,4),'filled','kh')
hold on
scatter(t,lockdown_italy(:,5),'filled','m^')
hold on
plot(t,fit_phase_1(:,3),'LineWidth',2.0,'Color','b')
hold on
plot(t,fit_phase_1(:,5),'LineWidth',2.0,'Color','r')
hold on
plot(t,fit_phase_1(:,6),'LineWidth',2.0,'Color',[0.9290 0.6940 0.1250])
hold on
plot(t,fit_phase_1(:,7),'LineWidth',2.0,'Color','k')
hold on
plot(t,fit_phase_1(:,8),'LineWidth',2.0,'Color','m')
xlim([t(1) t(end)]);
ylabel('Cases','fontsize',ImageFontSize);
xlabel('Days','fontsize',ImageFontSize);
title('(b)','position',[-1.5,25000],'FontSize',16);
set(gca,'fontsize',16,'fontweight','bold','FontName', 'Times New Roman')
set(gcf,'color','white')
grid on

subplot(2,3,4)
scatter(t,lockdown_italy_1(:,1),'filled','bo')
hold on
scatter(t,lockdown_italy_1(:,2),'filled','rs')
hold on
scatter(t,lockdown_italy_1(:,3),'p','MarkerFaceColor',[0.9290 0.6940 0.1250],'MarkerEdgeColor',[0.9290 0.6940 0.1250])
hold on
scatter(t,lockdown_italy_1(:,4),'filled','kh')
hold on
scatter(t,lockdown_italy_1(:,5),'filled','m^')
hold on
plot(t,fit_phase_2(:,3),'LineWidth',2.0,'Color','b')
hold on
plot(t,fit_phase_2(:,5),'LineWidth',2.0,'Color','r')
hold on
plot(t,fit_phase_2(:,6),'LineWidth',2.0,'Color',[0.9290 0.6940 0.1250])
hold on
plot(t,fit_phase_2(:,7),'LineWidth',2.0,'Color','k')
hold on
plot(t,fit_phase_2(:,8),'LineWidth',2.0,'Color','m')
xlim([t(1) t(end)]);
ylabel('Cases','fontsize',ImageFontSize);
xlabel('Days','fontsize',ImageFontSize);
title('(c)','position',[-1,60000],'FontSize',16);
set(gca,'fontsize',16,'fontweight','bold','FontName', 'Times New Roman')
set(gcf,'color','white')
grid on

subplot(2,3,5)
scatter(t1,lockdown_italy_2(:,1),'filled','bo')
hold on
scatter(t1,lockdown_italy_2(:,2),'filled','rs')
hold on
scatter(t1,lockdown_italy_2(:,3),'p','MarkerFaceColor',[0.9290 0.6940 0.1250],'MarkerEdgeColor',[0.9290 0.6940 0.1250])
hold on
scatter(t1,lockdown_italy_2(:,4),'filled','kh')
hold on
scatter(t1,lockdown_italy_2(:,5),'filled','m^')
hold on
plot(t1,fit_phase_all(:,3),'LineWidth',2.0,'Color','b')
hold on
plot(t1,fit_phase_all(:,5),'LineWidth',2.0,'Color','r')
hold on
plot(t1,fit_phase_all(:,6),'LineWidth',2.0,'Color',[0.9290 0.6940 0.1250])
hold on
plot(t1,fit_phase_all(:,7),'LineWidth',2.0,'Color','k')
hold on
plot(t1,fit_phase_all(:,8),'LineWidth',2.0,'Color','m')
xlim([t1(1) t1(end)]);
ylabel('Cases','fontsize',ImageFontSize);
xlabel('Days','fontsize',ImageFontSize);
title('(d)','position',[-4,100000],'FontSize',16);
set(gca,'fontsize',16,'fontweight','bold','FontName', 'Times New Roman')
set(gcf,'color','white')
grid on

% add a bit space to the figure
fig = gcf;
fig.Position(1) = fig.Position(1) + 200;
% add legend
Lgnd = legend({'Actual Diagnosed','Actual Recognised','Actual Threatened','Actual Healing','Actual Extinct',...
'Fitted Diagnosed','Fitted Recognised','Fitted Threatened','Fitted Healing','Fitted Extinct'},'Location','SouthOutside');
Lgnd.Position(1) = 0.52;
Lgnd.Position(2) = 0.3;


%% Infected and Ailing population for the four phases 

subplot(2,3,1)
plot(t,fit(:,2),t,fit(:,4),'linewidth',2)
xlim([t(1) t(end)]);
ylabel('Cases','Position',[-0.8 3200]);
xlabel('Days');
xlim([t(1) t(end)]);
title('(a)','position',[-1.5,5500],'FontSize',16);
set(gca,'fontsize',16,'fontweight','bold','FontName', 'Times New Roman')
set(gcf,'color','white')

subplot(2,3,2)
plot(t,fit_phase_1(:,2),t,fit_phase_1(:,4),'linewidth',2)
ylabel('Cases');
xlabel('Days');
xlim([t(1) t(end)]);
title('(b)','position',[-0.5,45000],'FontSize',16);
set(gca,'fontsize',16,'fontweight','bold','FontName', 'Times New Roman')
set(gcf,'color','white')

subplot(2,3,4)
plot(t,fit_phase_2(:,2),t,fit_phase_2(:,4),'linewidth',2)
ylabel('Cases');
xlabel('Days');
xlim([t(1) t(end)]);
title('(c)','position',[-0.5,57000],'FontSize',16);
set(gca,'fontsize',16,'fontweight','bold','FontName', 'Times New Roman')
set(gcf,'color','white')

subplot(2,3,5)
plot(t1,fit_phase_all(:,2),t1,fit_phase_all(:,4),'linewidth',2)
ylabel('Cases');
xlabel('Days');
xlim([t1(1) t1(end)]);
title('(d)','position',[-2,55000],'FontSize',16);
set(gca,'fontsize',16,'fontweight','bold','FontName', 'Times New Roman')
set(gcf,'color','white')

fig = gcf;
fig.Position(3) = fig.Position(3) + 200;
% % add legend
Lgnd = legend({'Infected','Ailing'},'Location','SouthOutside');
Lgnd.Position(1) = 0.55;
Lgnd.Position(2) = 0.45;

%% Plot actual vs diagosed infection and recovered cases
subplot(2,3,1)
plot(t,fit(:,10),'b',t,fit(:,2)+fit(:,3)+fit(:,4)+fit(:,5)+fit(:,6),'r',t,fit(:,7),'k','LineWidth',2.0)
hold on
plot(t,fit(:,3)+fit(:,5)+fit(:,6)+fit(:,7)+fit(:,8),'b--o',t,fit(:,3)+fit(:,4)+fit(:,5),'r--',t,fit(:,9),'--k','LineWidth',2.0);
title('(a)','position',[-3,14500],'FontSize',16);
xlabel('Days');
ylabel('Cases');
xlim([t(1) t(end)]); 
set(gca,'fontsize',18,'fontweight','bold','FontName', 'Times New Roman')
set(gcf,'color','white')
grid on 

subplot(2,3,2)
plot(t,fit_phase_1(:,10),'b',t,fit_phase_1(:,2)+fit_phase_1(:,3)+fit_phase_1(:,4)+fit_phase_1(:,5)+fit_phase_1(:,6),'r',t,fit_phase_1(:,7),'k','LineWidth',2.0)
hold on
plot(t,fit_phase_1(:,3)+fit_phase_1(:,5)+fit_phase_1(:,6)+fit_phase_1(:,7)+fit_phase_1(:,8),'b--o',t,fit_phase_1(:,3)+fit_phase_1(:,4)+fit_phase_1(:,5),'r--',t,fit_phase_1(:,9),'--k','LineWidth',2.0);
title('(b)','position',[-1,105000],'FontSize',16);
xlabel('Days');
ylabel('Cases');
xlim([t(1) t(end)]); 
set(gca,'fontsize',18,'fontweight','bold','FontName', 'Times New Roman')
set(gcf,'color','white')
grid on

subplot(2,3,4)
plot(t,fit_phase_2(:,10),'b',t,fit_phase_2(:,2)+fit_phase_2(:,3)+fit_phase_2(:,4)+fit_phase_2(:,5)+fit_phase_2(:,6),'r',t,fit_phase_2(:,7),'k','LineWidth',2.0)
hold on
plot(t,fit_phase_2(:,3)+fit_phase_2(:,5)+fit_phase_2(:,6)+fit_phase_2(:,7)+fit_phase_2(:,8),'b--o',t,fit_phase_2(:,3)+fit_phase_2(:,4)+fit_phase_2(:,5),'r--',t,fit_phase_2(:,9),'--k','LineWidth',2.0);
title('(c)','position',[-3,200000],'FontSize',16);
xlabel('Days');
ylabel('Cases');
xlim([t(1) t(end)]); 
set(gca,'fontsize',18,'fontweight','bold','FontName', 'Times New Roman')
set(gcf,'color','white')
grid on

subplot(2,3,5)
plot(t1,fit_phase_all(:,10),'b',t1,fit_phase_all(:,2)+fit_phase_all(:,3)+fit_phase_all(:,4)+fit_phase_all(:,5)+fit_phase_all(:,6),'r',t1,fit_phase_all(:,7),'k','LineWidth',2.0)
hold on
plot(t1,fit_phase_all(:,3)+fit_phase_all(:,5)+fit_phase_all(:,6)+fit_phase_all(:,7)+fit_phase_all(:,8),'b--o',t1,fit_phase_all(:,3)+fit_phase_all(:,4)+fit_phase_all(:,5),'r--',t1,fit_phase_all(:,9),'--k','LineWidth',2.0);
title('(d)','position',[-4,300000],'FontSize',16);
xlabel('Days');
ylabel('Cases');
xlim([t1(1) t1(end)]); 
set(gca,'fontsize',18,'fontweight','bold','FontName', 'Times New Roman')
set(gcf,'color','white')
grid on

fig = gcf;
fig.Position(3) = fig.Position(3) + 600;
% add legend
Lgnd = legend({'Cumulative Infected','Current Total Infected', 'Recovered','Diagnosed Cumulative Infected','Diagnosed Current Total Infected', 'Diagnosed Recovered'},'Location','northwest');
Lgnd.Position(1) = 0.60;
Lgnd.Position(2) = 0.3;

%% Param distribution for each phase 
Phatss=Phatss(:,[1,2,3,2,4,5,6,5,6,7,8,9,10,11,9,12]);
 Phatss_lock_1=Phatss_lock_1(:,[1,2,3,2,4,5,6,5,6,7,8,9,10,11,9,12]);
 Phatss_lock_2=Phatss_lock_2(:,[1,2,3,2,4,5,6,5,6,7,8,9,10,11,9,12]);
 Phatss_lock_all=Phatss_lock_all(:,[1,2,3,2,4,5,6,5,6,7,8,9,10,11,9,12]);

%% Plot param distribution for each phase 

subplot(2,1,1)
hAx=gca;
h1=boxplot(Phatss,'Notch','off','Labels',{'\alpha','\beta','\gamma', '\delta', '\epsilon', '\zeta', '\lambda', '\eta', '\rho', '\theta', '\mu', '\kappa', '\nu', '\sigma', '\xi', '\tau'})
for ih=1:6
set(h1(ih,:),'LineWidth',2);
end
ylim([-0.1 1.0]);
hAx.XAxis.TickLabelInterpreter='tex';
ylabel({('Parameter value'),(' distribution')});
title('(a)','position',[-1,1],'FontSize',16);
set(gca,'fontsize',16,'fontweight','bold','FontName', 'Times New Roman','LineWidth',2)
set(gcf,'color','white')

subplot(2,1,2)
bBx=gca;
h2=boxplot(Phatss_lock_1,'Notch','off','Labels',{'\alpha','\beta','\gamma', '\delta', '\epsilon', '\zeta', '\lambda', '\eta', '\rho', '\theta', '\mu', '\kappa', '\nu', '\sigma', '\xi', '\tau'})
ylim([-0.1 1.1]);
for ih=1:6
set(h2(ih,:),'LineWidth',2);
end
bBx.XAxis.TickLabelInterpreter='tex';
ylabel({('Parameter value'),(' distribution')});
title('(b)','position',[-1,1.1],'FontSize',16);
set(gca,'fontsize',16,'fontweight','bold','FontName', 'Times New Roman','LineWidth',2)
set(gcf,'color','white')


subplot(2,1,1)
cCx=gca;
h3=boxplot(Phatss_lock_2,'Notch','off','Labels',{'\alpha','\beta','\gamma', '\delta', '\epsilon', '\zeta', '\lambda', '\eta', '\rho', '\theta', '\mu', '\kappa', '\nu', '\sigma', '\xi', '\tau'})
ylim([-0.1 1.0]);
for ih=1:6
set(h3(ih,:),'LineWidth',2);
end
cCx.XAxis.TickLabelInterpreter='tex';
ylabel({('Parameter value'),(' distribution')});
title('(c)','position',[-1,1],'FontSize',16);
set(gca,'fontsize',16,'fontweight','bold','FontName', 'Times New Roman','LineWidth',2)
set(gcf,'color','white')


subplot(2,1,2)
dDx=gca;
h4=boxplot(Phatss_lock_all,'Notch','off','Labels',{'\alpha','\beta','\gamma', '\delta', '\epsilon', '\zeta', '\lambda', '\eta', '\rho', '\theta', '\mu', '\kappa', '\nu', '\sigma', '\xi', '\tau'})
ylim([-0.1 1.0]);
for ih=1:6
set(h4(ih,:),'LineWidth',2);
end
dDx.XAxis.TickLabelInterpreter='tex';
ylabel({('Parameter value'),(' distribution')});
title('(d)','position',[-1,1],'FontSize',16);
set(gca,'fontsize',16,'fontweight','bold','FontName', 'Times New Roman','LineWidth',2)
set(gcf,'color','white')

%% Param distribution for each parameter across the four phases
p16=zeros(16,1);
letter={'(a)', '(b)', '(c)', '(d)', '(e)', '(f)', '(g)', '(g)', '(h)', '(i)', '(j)', '(k)', '(l)','(m)','(n)', '(o)'};
values=[1:16];
greek={'\alpha','\beta','\gamma', '\delta', '\epsilon', '\zeta', '\lambda', '\eta', '\rho', '\theta', '\mu', '\kappa', '\nu', '\sigma', '\xi', '\tau'};
for i =1:16
    figure(i)
    p16=boxplot([Phatss(:,values(i)),Phatss_lock_1(:,values(i)),Phatss_lock_2(:,values(i)),Phatss_lock_all(:,values(i))],'Notch','off','Labels',{'I','II','III','IV'});
for ih=1:6
set(p16(ih,:),'LineWidth',2);
end
    ylim([-0.1 1.1]);
    ylabel({('Parameter value'),(' distribution')});
    title(greek{i},'FontSize',16);
    set(gca,'fontsize',16,'fontweight','bold','FontName', 'Times New Roman','LineWidth',2)
    set(gcf,'color','white')
end

%%







 
