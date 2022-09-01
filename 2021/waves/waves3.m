#f1 =@(x,v,w,t) sin((w/v)*x-w*t);
clear all;
close all;
clc;

L=1




n=1

a0=1

a= @(n) (2/(n*pi))*(-1)^((n-1)/2)

x=linspace(-L,L)

f0=a0
f1= @(x) a(1)*cos(pi*x/L)
f3=@(x) a(3)*cos(3*pi*x/L)
f5=@(x) a(5)*cos(5*pi*x/L)
f7=@(x) a(7)*cos(7*pi*x/L)
f9=@(x) a(9)*cos(9*pi*x/L)

linea= @ (x) 1+0.00001*x

xl=linspace(-L/2,L/2)

plot(xl,linea(x))
hold on
plot([-L/2,-L/2],[0,1],'b');
plot([L/2,L/2],[0,1],'b');
plot([-L,-L/2],[0,0],'b');
plot([L/2,L],[0,0],'b');

plot (x,0.5*a0+f1(x)+f3(x)+f5(x)+f7(x)+f9(x))
hold off
#axis([-L L  -2 2]);
