


dt=0.1
dw=0.01
t=0
v=2
w=1
w1=1
w2=5
xp=5
xp1=0
b=1
c=1

k=w1/v


f1 =@(x,v,w,t) sin((w/v)*x-w*t);


for i=1:200
  
t +=dt;




y1=f1(x,v,w1,t);
xp1=0;
yp1=f1(xp1,v,w1,t);


y2=f1(x,v,w2,t);

xp2=0;
yp2=f1(xp2,v,w2,t);


x=linspace(0,v*t,500)
  
plot(x,y1,'b',xp1,yp1,'ob');

hold on
plot(x,y2,'r',xp2,yp2,'or');
hold off

axis([0 20  -2 2]);

filename=sprintf('E:/Digipen/PHY250/2021/waves/Animation2/%05d.png',i);
print(filename);
  
  
  
endfor