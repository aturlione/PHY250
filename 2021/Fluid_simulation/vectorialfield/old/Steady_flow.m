l=-10

u=10

Nh=30
Nv=10

v0=0.5

x=linspace(l,u,Nh); 
y=linspace(l,u,Nv); 

[xg,yg]=meshgrid(x,y);

A=1/20
B=7


y1=-A*x.^3+B
y2=A*x.^3-B



%------------Velocity field------------

vx=(v0.*B.^2 ./(-A.*xg.^3+B).^2)
vy=0


plot(x,y1)
hold on
plot(x,y2)


%---------------Plot vectorial field
h = quiver (xg, yg, vx, vy,'AutoScale','off');
hold off
  
  
axis([l/2 u/2 2*l 2*u])