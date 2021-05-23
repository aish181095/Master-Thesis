function dydt = sidartheode(t,x,p) 
       
          %The eight differential equations representing the eight
          %compartments of the SIDARTHE model.
           
           dydt=zeros(10,1);
           dydt(1)=   -x(1)*(p(1)*x(2)+p(2)*x(3)+p(3)*x(4)+p(2)*x(5));%S 
           dydt(2)=   x(1)*(p(1)*x(2)+p(2)*x(3)+p(3)*x(4)+p(2)*x(5))-(p(4)+p(5)+p(6))*x(2);%I
           dydt(3)=   p(4)*x(2)-(p(5)+p(6))*x(3);%D
           dydt(4)=   p(5)*x(2)-(p(7)+p(8)+p(9))*x(4);%A
           dydt(5)=   p(5)*x(3)+p(7)*x(4)-(p(10)+p(9))*x(5);%R
           dydt(6)=   p(8)*x(4)+p(10)*x(5)-(p(11)+p(12))*x(6);%T
           dydt(7)=   p(6)*x(2)+p(6)*x(3)+p(9)*x(4)+p(9)*x(5)+p(11)*x(6);%H
           dydt(8)=   p(12)*x(6);%E
           dydt(9)=   p(6)*x(3)+p(9)*x(5)+p(11)*x(6);%H_diagnost
          dydt(10)=   x(1).*(p(1)*x(2)+p(2)*x(3)+p(3)*x(4)+p(2)*x(5));%Infectti_real
           
          
  


end