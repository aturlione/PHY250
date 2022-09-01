
x=linspace(-10,40,1000)

dt=0.1;
t=0;
k1=pi;
k2=2*pi;
k3=3*pi;
k4=4*pi;
w=2*pi
v=1
b=1
c=1


f1 =@(x,t) e.^(-(x-v*t-b).^2/(2*c^2))
f2=@(x,t) e.^(-(x+v*t-b-25).^2/(2*c^2))

for i=1:200
t +=dt





plot(x,f1(x,t)+f2(x,t));
 ylabel("D(x,t)","fontsize", 16); 
 xlabel("x","fontsize", 16); 
 
#hold on

#plot(x,y1,'r',x,y2,'r',x,y3,'r',x,y4,'r');
#hold off





axis([0 50  -5 5]);

filename=sprintf('E:/Digipen/PHY250/2021/waves/Animation8/%05d.png',i);
print(filename);
  
  
  
endfor