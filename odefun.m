

% function dydt = odefun(t,x,p) 
%        
%           dydt=zeros(8,1);
%            dydt(1)=    -x(1)*(p(1)*x(2)+p(2)*x(3)+p(3)*x(4)+p(4)*x(5)); 
%            dydt(2)=   x(1)*(p(1)*x(2)+p(2)*x(3)+p(3)*x(4)+p(4)*x(5))-(p(5)+0.1254+0.0342)*x(2);
%            dydt(3)=   p(5)*x(2)-(0.1254+0.05)*x(3);
%            dydt(4)=  0.1254*x(2)-(p(6)+p(7)+0.0171)*x(4);
%            dydt(5)=   0.1254*x(3)+p(6)*x(3)-(p(8)+0.03)*x(5);
%            dydt(6)=   p(7)*x(4)+p(8)*x(5)-(p(9)+p(10))*x(6);
%            dydt(7)=   0.0342*x(2)+0.05*x(3)+0.0171*x(4)+0.03*x(5)+p(9)*x(6);
%            dydt(8)=   p(10)*x(6);
%                     
% end
function dydt = odefun(t,x,p) 
       
          dydt=zeros(8,1);
           dydt(1)=   -x(1)*(p(1)*x(2)+p(2)*x(3)+p(3)*x(4)+p(4)*x(5)); 
           dydt(2)=   x(1)*(p(1)*x(2)+p(2)*x(3)+p(3)*x(4)+p(4)*x(5))-(100+1.4340e-05+0.0019)*x(2);
           dydt(3)=   100*x(2)-(1.2450e-04+2.1682e-06)*x(3);
           dydt(4)=   1.4340e-05*x(2)-(0.8902+79.3815+33.6846)*x(4);
           dydt(5)=   1.2450e-04*x(3)+0.8902*x(3)-(0.0605+0.0245)*x(5);
           dydt(6)=   79.3815*x(4)+0.0605*x(5)-(p(5)+p(6))*x(6);
           dydt(7)=   0.0019*x(2)+2.1682e-06*x(3)+33.6846*x(4)+0.0245*x(5)+p(5)*x(6);
           dydt(8)=   p(6)*x(6);
                    
end

