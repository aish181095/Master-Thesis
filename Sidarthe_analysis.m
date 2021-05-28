
function S=Sidarthe_analysis(p)


% Evaluate model at for paramater values
 

fit=table2array(readtable('fit_all.csv'));
n=14;
S=cell(n,1);

for i=1:n

    
 TT=[];
 pvv=[];
 x00=[];
 %time_t=[];
 t=[0 1];
 x0=fit(i,:);
 
for k=0:249
     %options=odeset('SensitivityAnalysis', true);
 [T,pv]=ode45(@(t,x)sidartheode(t,x,p),t,x0);%for runing the code for optimisation for certain parameters from the curve_fitting.m use the odefun.m file for 16 parameters use odefun1.m.
     x0=pv(end,:);%initial points stored 
     %time=T(end,:);
     %time_t=[time_t;time];%storing the time points for each propgation interval currenlty does not seem to store correctly
     x00=[x00;x0];     
     TT=[TT;T+k];%time points stored
     pvv=[pvv;pv]; %ode systems values stored
end
%save end point x and distance from data point  

S{i,1}=x00;
end
end