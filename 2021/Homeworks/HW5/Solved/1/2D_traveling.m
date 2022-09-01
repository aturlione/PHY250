tx = ty = linspace (-4*pi, 4*pi, 100)';
[xx, yy] = meshgrid (tx, ty);

w=1
t=0
dt=0.1
factor=2

for i=1:200
t +=dt



#tz = sin (2*sqrt(xx.^2+yy.^2)-w*t) 
#tz = sin (2*(xx+yy)-w*t)
tz = sin (2*(xx)-w*t)
S=surf (tx, ty, tz);

#view(45, 60)
view(15, 40)

set(S,'edgecolor','none');


axis([-factor*pi factor*pi  -factor*pi factor*pi -2 2 ]);

filename=sprintf('E:/Digipen/PHY250/2021/waves/Animation11/%05d.png',i);
print(filename);
  

  
endfor