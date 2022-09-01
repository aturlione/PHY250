


dt=0.1
dw=0.01
t=0
v=2
w=1.3

xp=5
xp1=0
b=1
c=1

k=w1/v


f1 =@(x,v,w,t) sin((w/v)*x-w*t);
f2 =@(x,v,w,t) sin((w/v)*x+w*t);

x=linspace(0,10,500)

for i=1:200
  
t +=dt;




y1=f1(x,v,w1,t);


if(t>10/v)



endif

  
#plot(x,y1,'b');
#hold on
#plot(x,y2,'r');

plot(x,y1+y2+y3+y4,'k');


#hold off



axis([0 10  -5 5]);

filename=sprintf('E:/Digipen/PHY250/2021/waves/Animation2/%05d.png',i);
print(filename);
  
  
  
endfor