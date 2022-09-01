
tt=0:0.1:100

#IC
phi=0;
k=1;
m=1;
A=1;
b=0.1;
g=b/(2*m)
F0=1

#fundamental frequency
w0=sqrt(k/m);
#damped frequency
w_d= @(b) sqrt(k/m-b^2/(4*m^2));

#critical damping
b_cri=sqrt(4*m*k)

#Harmonic oscillation
x_HO=@ (t) A*cos(w0*t+phi) ;
v_HO=@ (t) -A*w0*sin(w0*t+phi);
a_HO=@ (t) -A*w0^2*cos(w0*t+phi);

#Damped oscillation ##ERROR: ESTOY USANDO SIEMPRE EL MIMO GAMMA!
x_d=@ (t,b) A.*e.^(-g*t).*cos(w_d(b)*t+phi);
v_d=@ (t,b) -g*A*exp(-g*t).*cos(w_d(b)*t+phi) -A*w_d(b)*exp(-g*t).*sin(w_d(b)*t+phi);
a_d=@ (t,b) g^2*A*exp(-g*t).*cos(w_d(b)*t+phi)+g*A*exp(-g*t).*w_d(b).*sin(w_d(b)*t+phi)+  A*g*w_d(b).*exp(-g*t).*sin(w_d(b)*t+phi)-A*w_d(b)^2*exp(-g*t).*sin(w_d(b)*t+phi);

#time step
dt=0.1;
time=0;


for i=1:300
time +=dt;

x1= x_HO(time);
y1= 1;

x2=x_d(time,b);
y2=1.2;

x3=x_d(time,b+1);
y3=1.4;


x4=x_d(time,b_cri);
y4=1.6


#plots
subplot (2,1,1)
plot(x1,y1,'ob',x2,y2,'or',x3,y3,'og',x4,y4,'om')  
axis([-3 3 0.5 2]); %invert axes "ij"
xlabel("x","fontsize", 16);
ylabel("y","fontsize", 16);
   
subplot (2,1,2)
plot(tt,x_HO(tt),'b--',time,x1,'*b',time,x2,'*r',time,x3,'*g',time,x4,'*m')  
hold on
plot(tt,x_d(tt,b),'r')  
hold on
plot(tt,x_d(tt,b +1),'g') 

hold on
plot(tt,x_d(tt,b_cri),'m') 

hold off
axis([0 50 -1.5 1.5]); %invert axes "ij"

xlabel("t","fontsize", 16);
ylabel("x","fontsize", 16);
   
filename=sprintf('E:/Digipen/PHY250/2021/Damped_Oscillations/Animation/%05d.png',i);
print(filename);
  


endfor