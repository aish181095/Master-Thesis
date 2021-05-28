%%Sensitivty analysis


%%Run the model for each phase for a period of 2000 days to stabilise.

%% Plot the equilibrium for the four phases
n = size(1,8);
colors = hsv(8);

subplot(2,3,1)
equilibria_1=plot(before_lock(:,1:8),'linewidth',2);
ylim([-0.1 1.1]);
ylabel({('Cases'),('(Fraction of population)')});
xlabel('Days');
set(equilibria_1, {'color'}, num2cell(colors, 2));
title('(a)','position',[-20,1.2],'FontSize',16);
set(gca,'fontsize',16,'fontweight','bold','FontName', 'Times New Roman')
set(gcf,'color','white')

subplot(2,3,2)
equilibria_2=plot(lock_phase_1(:,1:8),'linewidth',2);
ylim([-0.1 1.1]);
ylabel({('Cases'),('(Fraction of population)')});
xlabel('Days');
set(equilibria_2, {'color'}, num2cell(colors, 2));
title('(b)','position',[-20,1.2],'FontSize',16);
set(gca,'fontsize',16,'fontweight','bold','FontName', 'Times New Roman')
set(gcf,'color','white')

subplot(2,3,4)
equilibria_3=plot(lock_phase_2(:,1:8),'linewidth',2);
ylim([-0.1 1.1]);
ylabel({('Cases'),('(Fraction of population)')});
xlabel('Days');
set(equilibria_3, {'color'}, num2cell(colors, 2));
title('(c)','position',[-20,1.2],'FontSize',16);
set(gca,'fontsize',16,'fontweight','bold','FontName', 'Times New Roman')
set(gcf,'color','white')

subplot(2,3,5)
equilibria_4=plot(lock_phase_all(:,1:8),'linewidth',2)
ylim([-0.1 1.1]);
ylabel({('Cases'),('(Fraction of population)')});
xlabel('Days');
set(equilibria_4, {'color'}, num2cell(colors, 2));
title('(d)','position',[-20,1.2],'FontSize',16);
set(gca,'fontsize',16,'fontweight','bold','FontName', 'Times New Roman')
set(gcf,'color','white')

fig = gcf;
fig.Position(1) = fig.Position(1) + 200;
% add legend
Lgnd = legend({'Susceptible','Infected','Diagnosed','Ailing','Recognised','Threatened','Healing','Extinct'},'Location','SouthOutside');
Lgnd.Position(1) = 0.57;
Lgnd.Position(2) = 0.3;
%%
delta=0.01;%set the deviation value
%set the values of the parameters for each phase
parameter_sensitivity= zeros(1,12);
parameter_sensitivity(1)=0.0042;
parameter_sensitivity(2)=0.0009;
parameter_sensitivity(3)=0.00093;
parameter_sensitivity(4)=0.0507;
parameter_sensitivity(5)=0.0005;
parameter_sensitivity(6)=0.0156;
parameter_sensitivity(7)=0.0007;
parameter_sensitivity(8)=0.0006;
parameter_sensitivity(9)=0.000068;
parameter_sensitivity(10)=0.0150;
parameter_sensitivity(11)=0.0001;
parameter_sensitivity(12)=0.1610;

true_ode=Curvefit_model(parameter_sensitivity);

%%
%positively deviated parameter values (one at a time)
deviated_values=repmat(parameter_sensitivity,12,1);
deviated_values(1,1)=deviated_values(1,1)+delta;
deviated_values(2,2)=deviated_values(2,2)+delta;
deviated_values(3,3)=deviated_values(3,3)+delta;
deviated_values(4,4)=deviated_values(4,4)+delta;
deviated_values(5,5)=deviated_values(5,5)+delta;
deviated_values(6,6)=deviated_values(6,6)+delta;
deviated_values(7,7)=deviated_values(7,7)+delta;
deviated_values(8,8)=deviated_values(8,8)+delta;
deviated_values(9,9)=deviated_values(9,9)+delta;
deviated_values(10,10)=deviated_values(10,10)+delta;
deviated_values(11,11)=deviated_values(11,11)+delta;
deviated_values(12,12)=deviated_values(12,12)+delta;

%negatively deviated parameter values (one at a time)
deviated_values_neg=repmat(parameter_sensitivity,12,1);
deviated_values_neg(1,1)=deviated_values_neg(1,1)-delta;
deviated_values_neg(2,2)=deviated_values_neg(2,2)-delta;
deviated_values_neg(3,3)=deviated_values_neg(3,3)-delta;
deviated_values_neg(4,4)=deviated_values_neg(4,4)-delta;
deviated_values_neg(5,5)=deviated_values_neg(5,5)-delta;
deviated_values_neg(6,6)=deviated_values_neg(6,6)-delta;
deviated_values_neg(7,7)=deviated_values_neg(7,7)-delta;
deviated_values_neg(8,8)=deviated_values_neg(8,8)-delta;
deviated_values_neg(9,9)=deviated_values_neg(9,9)-delta;
deviated_values_neg(10,10)=deviated_values_neg(10,10)-delta;
deviated_values_neg(11,11)=deviated_values_neg(11,11)-delta;
deviated_values_neg(12,12)=deviated_values_neg(12,12)-delta;

deviated_values_neg=max(deviated_values_neg,0);%set negative parameter values to 0.
%%
%propagate the model for positively and negatively deviated parameter
%values.
Sens_ode=cell(12,1);
Sens_ode_neg=cell(12,1);
for i = 1:length(parameter_sensitivity)
       
   Sens_ode{i,1}=LSCostFunction_1(deviated_values(i,:));
   Sens_ode_neg{i,1}=LSCostFunction_1(deviated_values_neg(i,:));
end

%%
%calculate the distance between true and deviated equilibrium.
error_pos=zeros(12,2);
for i= 1:12
    error_pos(i,1)=sqrt((true_ode(end,1)-Sens_ode{i,1}(end,1)).^2 +...
        (true_ode(end,2)-Sens_ode{i,1}(end,2)).^2 +...
        (true_ode(end,3)-Sens_ode{i,1}(end,3)).^2 +...
        (true_ode(end,4)-Sens_ode{i,1}(end,4)).^2 +...
        (true_ode(end,5)-Sens_ode{i,1}(end,5)).^2 +...
        (true_ode(end,6)-Sens_ode{i,1}(end,6)).^2 +...
        (true_ode(end,7)-Sens_ode{i,1}(end,7)).^2 +...
        (true_ode(end,8)-Sens_ode{i,1}(end,8)).^2);
    error_pos(i,2)=sqrt((true_ode(end,1)-Sens_ode_neg{i,1}(end,1)).^2 +...
        (true_ode(end,2)-Sens_ode_neg{i,1}(end,2)).^2 +...
        (true_ode(end,3)-Sens_ode_neg{i,1}(end,3)).^2 +...
        (true_ode(end,4)-Sens_ode_neg{i,1}(end,4)).^2 +...
        (true_ode(end,5)-Sens_ode_neg{i,1}(end,5)).^2 +...
        (true_ode(end,6)-Sens_ode_neg{i,1}(end,6)).^2 +...
        (true_ode(end,7)-Sens_ode_neg{i,1}(end,7)).^2 +...
        (true_ode(end,8)-Sens_ode_neg{i,1}(end,8)).^2);
    
end

