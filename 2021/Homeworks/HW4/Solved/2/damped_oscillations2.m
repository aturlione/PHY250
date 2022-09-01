
tt=0:0.1:100


phi=0;
k=1;
m=1;
A=1;
b=0.1;
g=b/(2*m);
F0=1

b_cri=sqrt(4*m*k)

w0=sqrt(k/m);
w_d= @(b) sqrt(k/m-b^2/(4*m^2));


x_HO=@ (t) A*cos(w0*t+phi) ;
v_HO=@ (t) -A*w0*sin(w0*t+phi);
a_HO=@ (t) -A*w0^2*cos(w0*t+phi);

x_d=@ (t,b) A.*e.^(-g*t).*cos(w_d(b)*t+phi);
v_d=@ (t,b) -g*A*exp(-g*t).*cos(w_d(b)*t+phi) -A*w_d(b)*exp(-g*t).*sin(w_d(b)*t+phi);
a_d=@ (t,b) g^2*A*exp(-g*t).*cos(w_d(b)*t+phi)+g*A*exp(-g*t).*w_d(b).*sin(w_d(b)*t+phi)+  A*g*w_d(b).*exp(-g*t).*sin(w_d(b)*t+phi)-A*w_d(b)^2*exp(-g*t).*sin(w_d(b)*t+phi);


dt=0.05;
time=0;
b=0
imax=100

for i=1:imax


b =i*b_cri/imax




subplot (3,1,1)
plot(tt,x_HO(tt))  
hold on
plot(tt,x_d(tt,b)) 
 ylabel("x","fontsize", 16); 
hold off
axis([0 50 -1.5 1.5]); %invert axes "ij"


subplot (3,1,2)
plot(tt,v_HO(tt)) 
hold on
 ylabel("v","fontsize", 16);
plot(tt,v_d(tt,b))  
hold off 
axis([0 50 -1.5 1.5]); %invert axes "ij"

subplot (3,1,3)
plot(tt,a_HO(tt)) 
hold on
 ylabel("a","fontsize", 16);
plot(tt,a_d(tt,b))  
hold off  
axis([0 50 -1.5 1.5]); %invert axes "ij"

   
filename=sprintf('E:/Digipen/PHY250/2021/Damped_Oscillations/Animation/%05d.png',i);
print(filename);
  
  


endfor
