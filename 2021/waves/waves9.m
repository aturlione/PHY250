


dt=0.5
dw=0.01
t=0
v=2
w=1.

xp=5
xp1=0
b=1
c=1

k=w1/v
A=0.1




f1 =@(x,v,w,t) sin((w/v)*x-w*t);
f2 =@(x,v,w,t) sin((w/v)*x+w*t);







for i=1:50
  
t +=dt;


x=linspace(-pi*(v/w)+v*t,pi*(v/w)+v*t,500)
y=A*sin((w/v)*x-w*t)

if (t>10/v)
x=linspace(-pi*(v/w)-v*t,pi*(v/w)-v*t,500)
y=-A*sin((w/v)*x+w*t)
endif
  
#plot(x,y1,'b');
#hold on
#plot(x,y2,'r');

plot(x,y,'k');
hold on
plot([-100,-pi*(v/w)+v*t], [0,0],'k');
plot([pi*(v/w)+v*t,100], [0,0],'k');
axis([0 10  -1 1]);
hold off





filename=sprintf('E:/Digipen/PHY250/2021/waves/Animation2/%05d.png',i);
print(filename);
  
  
  
endfor