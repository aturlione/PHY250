
tt=0:0.1:100
omega=0:0.01:100

phi=0;
k=1;
m=1;
A=1;
b=0.1;
g=b/(2*m);
F0=1

b_cri=sqrt(4*m*k)

w0=sqrt(k/m);


w_f=0;


A_f =@ (w,b) F0./sqrt((w.^2-w0.^2).^2+b^2*w.^2/m^2);
phi_f=@ (w,b) atan((w0^2-w^2)/(w*(b/m)));


x_HO=@ (t) A*cos(w0*t+phi) ;
v_HO=@ (t) -A*w0*sin(w0*t+phi);
a_HO=@ (t) -A*w0^2*cos(w0*t+phi);

xf0=A_f(0,b)*sin(phi_f(0,b))

x_f= @ (t,w,b) A_f(w,b)*sin(w*t+phi_f(w,b))-A_f(0,b)*sin(phi_f(0,b));

dt=0.1;
time=0;
imax=300

for i=1:imax
time +=dt;
w_f +=0.01

x1= x_HO(time);
y1= 1;



x3=x_f(time,w_f,b);
y3=1.5



subplot (3,1,1)
plot(x1,y1,'o',x3,y3,'o')  
axis([-15 15 0.5 2]); %invert axes "ij"

 ylabel("y","fontsize", 16); 
 xlabel("x","fontsize", 16); 
 
subplot (3,1,2)
plot(tt,x_HO(tt),time,x_HO(time),'*b')  
hold on
plot(tt,x_f(tt,w_f,b),time,x_f(time,w_f,b),'*r')  
hold off
axis([0 50 -15 15]); %invert axes "ij"
 ylabel("x","fontsize", 16); 
 xlabel("t","fontsize", 16); 
 
subplot (3,1,3)
plot(omega,A_f(omega,b),'r',w_f,A_f(w_f,b),'*r')  

axis([0 2 -1.5 15]); %invert axes "ij"
 ylabel("A","fontsize", 16); 
 xlabel("w","fontsize", 16);    
filename=sprintf('E:/Digipen/PHY250/2021/Forced_Oscillations/Animation/%05d.png',i);
print(filename);
  
  


endfor
