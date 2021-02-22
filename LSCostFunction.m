%% calculate error
function S=LSCostFunction(p,t)

% Evaluate model at for paramater values
 % Evaluate model at for paramater values
 TT=[];
 pvv=[];
 x00=[];
 %time_t=[];
 t=[0 1];
 %x0=[6.0413e+03 265.5 2180 737.5 4207 650 622 366];
 
 
parfor k=0:57
%     options=odeset('RelTol',1e-8,'AbsTol',1e-8);
 [T,pv]=ode45(@(t,x)odefun(t,x,p),t,[6.0413e+03 265.5 2180 737.5 4207 650 622 366]);%for runing the code for optimisation for certain parameters from the curve_fitting.m use the odefun.m file for 16 parameters use odefun1.m.
     x0=pv(end,:);%reseting intial point
     %time=T(end,:);
     %time_t=[time_t;time];%storing the time points for each propgation interval currenlty does not seem to store correctly
     x00=[x00;x0];%initial points stored 
     TT=[TT;T+k];%time points stored
     pvv=[pvv;pv]; %ode systems values stored
end
%save end point x and distance from data point  
S=x00;%assigning the variable S to x00; as it stores the ode systems values after propagation for three time interval
end
 
 
 