
tt=0:0.1:100


phi=0;
k=1;
m=1;
A=1;
b=0.1;
g=b/(2*m);
F0=1

w0=sqrt(k/m);
w_d= @(b) sqrt(k/m-b^2/(4*m^2));

w_f=w0;

A_f =@ (w,b) F0/(m*sqrt((w^-w0^2))^2+b^2*w^2/m^2);
phi_f=@ (w,b) atan((w0^2-w^2)/(w*(b/m)));


x_HO=@ (t) A*cos(w0*t+phi) ;
v_HO=@ (t) -A*w0*sin(w0*t+phi);
a_HO=@ (t) -A*w0^2*cos(w0*t+phi);

x_d=@ (t,b) A.*e.^(-g*t).*cos(w_d(b)*t+phi);
v_d=@ (t,b) -g*A*exp(-g*t).*cos(w_d(b)*t+phi) -A*w_d(b)*exp(-g*t).*sin(w_d(b)*t+phi);
a_d=@ (t,b) g^2*A*exp(-g*t).*cos(w_d(b)*t+phi)+g*A*exp(-g*t).*w_d(b).*sin(w_d(b)*t+phi)+  A*g*w_d(b).*exp(-g*t).*sin(w_d(b)*t+phi)-A*w_d(b)^2*exp(-g*t).*sin(w_d(b)*t+phi);

x_f= @ (t,w,b) A_f(w,b)*sin(w*t+phi_f(w,b));

dt=0.1;
time=0;

for i=1:10
time +=dt;

x1= x_HO(time);
y1= 1;

x2=x_d(time,b);
y2=1.5;

x3=x_f(time,w_f,b);
y3=2.



subplot (4,1,1)
plot(x1,y1,'o',x2,y2,'o')  
axis([-3 3 0.5 2]); %invert axes "ij"

subplot (4,1,2)
plot(tt,x_HO(tt),time,x_HO(time),'*b')  
hold on
plot(tt,x_d(tt,b),time,x_d(time,b),'*r')  
hold off
axis([0 50 -1.5 1.5]); %invert axes "ij"


subplot (4,1,3)
plot(tt,v_HO(tt),time,v_HO(time),'*b',time) 
hold on
plot(tt,v_d(tt,b),time,v_d(time,b),'*r')  
hold off 
axis([0 50 -1.5 1.5]); %invert axes "ij"

subplot (4,1,4)
plot(tt,a_HO(tt),time,a_HO(time),'*b') 
hold on
plot(tt,a_d(tt,b),time,a_d(time,b),'*r')  
hold off  
axis([0 50 -1.5 1.5]); %invert axes "ij"

   
filename=sprintf('E:/Digipen/PHY250/2021/HOM/Animation/%05d.png',i);
print(filename);
  
  


endfor
