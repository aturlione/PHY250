
#x=linspace(0,20,100)

dt=0.1
t=0
v=1
w1=1
w2=10
xp=5
xp1=0
b=1
c=1

k=w1/v

f1 =@(x,k,w,t) sin(k*x-w*t);
#f2 =@(x,v,t) e.^(-(x-v*t-b).^2/(2*c^2))

for i=1:300
t +=dt

y1=f1(x,k,w1,t);
yp=f1(xp,k,w1,t);
yp1=f1(xp1,k,w1,t);

y2= f2(x,v,t)

x=linspace(0,v*t,500)

plot(x,y1,'b',xp1,yp1,'ob');
 ylabel("sin(kx-\\omega t)","fontsize", 16); 
 xlabel("x","fontsize", 16); 
 
hold on

if (i>60)
plot(xp,yp,'or');
plot([5,5],[-2,2],'b');
endif
  
hold off


axis([0 20  -2 2]);

filename=sprintf('E:/Digipen/PHY250/2021/waves/Animation/%05d.png',i);
print(filename);
  
  
  
endfor