
x=linspace(-10,40,1000)

dt=0.1;
t=0;
k1=pi;
k2=2*pi;
k3=3*pi;
k4=4*pi;
w=2*pi



v =@(k) 10*k
f =@(x,k,tt) sin(k*x-(v(k)/w)*tt);


for i=1:200
t +=dt

y1=f(x,k1,t);
y2=f(x,k2,t);
y3=f(x,k3,t);
y4=f(x,k4,t);




plot(x,y1+y2+y3+y4);
 ylabel("D(x,t)","fontsize", 16); 
 xlabel("x","fontsize", 16); 
 






axis([0 5  -5 5]);

filename=sprintf('E:/Digipen/PHY250/2021/waves/Animation/%05d.png',i);
print(filename);
  
  
  
endfor