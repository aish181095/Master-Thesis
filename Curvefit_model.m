%% calculate error
function S=Curvefit_model(p)

 
 %create empty vectors for storing values
 TT=[];
 pvv=[];
 x00=[];
 d=14;%number of days
 t=[0 1];%set the time interval of one day

 
 % set the initial points
x0=zeros(1,10);


  % before lockdown phase initial point
% x0(2)=200/60e6;%2.4430e+03/60e6;%(200/60e6);
% x0(3)=0;%2180/60e6;%0;
% x0(4)=1/60e6;%410.3281/60e6;%(1/60e6);
% x0(5)=0;%4207/60e6;
% x0(6)=0;%650/60e6;
% x0(7)=0;%622/60e6;
% x0(8)=0;%366/60e6;
% x0(1)=(1-200/60e6-1/60e6);%1-x0(2)-x0(3)-x0(4)-x0(5)-x0(6)-x0(7)-x0(8);%1-200/60e6-1/60e6;
% x0(9)= x0(2)+x0(3)+x0(4)+x0(5)+x0(6);
% x0(10)=0;

% 14 days after lockdown phase initial point
% x0(2)=5.4202e+03/60e6;
% x0(3)=3.6333e-05;
% x0(4)=1.5575e+03/60e6;
% x0(5)=7.0117e-05;
% x0(6)=1.0833e-05;
% x0(7)=1.0367e-05;
% x0(8)=6.1000e-06;
% x0(1)=1-x0(2)-x0(3)-x0(4)-x0(5)-x0(6)-x0(7)-x0(8);
% % x0(9)= x0(2)+x0(3)+x0(4)+x0(5)+x0(6);
% x0(10)=1.5163e+04/60e6;

% 28 days after lockdown phase initial point
% x0(1)=1-x0(2)-x0(3)-x0(4)-x0(5)-x0(6)-x0(7)-x0(8);
% x0(2)=3.1133e+04/60e6;
% x0(3)=3.6860e-04;
% x0(4)=3.2596e+04/60e6;
% x0(5)=3.4275e-04;
% x0(6)=4.7617e-05;
% x0(7)=1.0120e-04;
% x0(8)=8.0417e-05;
% x0(1)=1-x0(2)-x0(3)-x0(4)-x0(5)-x0(6)-x0(7)-x0(8);
% x0(9)= x0(2)+x0(3)+x0(4)+x0(5)+x0(6);
% x0(10)=1.0819e+05/60e6;

% 32 days after lockdown phase initial point
x0(2)=6.1341e+04/60e6;
x0(3)=8.7632e-04;
x0(4)=1.5230e+04/60e6;
x0(5)=5.4682e-04;
x0(6)=6.7800e-05;
x0(7)=3.2930e-04;
x0(8)=2.4468e-04;
x0(1)=1-x0(2)-x0(3)-x0(4)-x0(5)-x0(6)-x0(7)-x0(8);
x0(9)= x0(2)+x0(3)+x0(4)+x0(5)+x0(6);
x0(10)=1.8912e+05/60e6;

 
 
for k=0:d-1
    %ode45 used to propagate the equations from sidartheode.m file.
     [T,pv]=ode45(@(t,x)sidartheode(t,x,p),t,x0);
     %time=T(end,:);% to store time points
     x0=pv(end,:);%initial points stored 
     x00=[x00;x0];%stores values for every compartment for each day
     TT=[TT;T+k];%time points stored
     pvv=[pvv;pv]; %ode systems values stored
end


%save values for each day 

%when fitting curve use the below storage command
%S=x00(:,[3,5,6,7,8])

%For storing values for all compartments in the model
S=x00;
end