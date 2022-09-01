#f1 =@(x,v,w,t) sin((w/v)*x-w*t);
#clear all;
#close all;
#clc;

L=1;




n=1;

a0=1;

a= @(n) (2/(n*pi))*(-1)^((n-1)/2);

Fourier=0.5*a0;

x=linspace(-L,L,500);


f=@(n,x) a(n)*cos(n*pi*x/L);

for i=1:100;
n=(2*i-1);
  
Fourier +=f(n,x);
  
plot (x,Fourier);
hold on


plot([-L/2,-L/2],[0,1],'b');
plot([L/2,L/2],[0,1],'b');
plot([-L,-L/2],[0,0],'b');
plot([L/2,L],[0,0],'b');
plot([-L/2,L/2],[1,1],'b');

 ylabel("f(x)","fontsize", 16); 
 xlabel("x","fontsize", 16); 
hold off

filename=sprintf('E:\\Digipen\\PHY250\\2021\\Homeworks\\HW4\\Solved\\3\\Animation\\%05d.png',i);
print(filename);


#axis([-L L  -2 2]);
end