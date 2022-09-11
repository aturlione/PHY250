a=1
v0=10 
N=10; % number of points in the grid
l=1


xx=linspace(-3,3,N); % x component

zz=linspace(-3,3,N);


[x,z]=meshgrid(xx,zz);
M=[x,z];
l=zeros(N);
%vx=x+z;
%vz=x+z;

vx=-(3*v0*a^3/2)*z.*x./sqrt(x.^2+z.^2).^5;
vz=v0+(v0*a^3/2)*(1 ./sqrt(x.^2+z.^2).^3-2*(z.^2)./sqrt(x.^2+z.^2).^5);


for i=1:N
  for j=1:N
    cond= sqrt(x(i,j)^2+z(i,j)^2);
    if (cond<a)
      vx(i,j)=0;
      vz(i,j)=0;
    endif
   endfor
endfor



xp=-1;
yp=-3;



dt=0.1
for i=1:10
  
vxp = interp2 (x, z, vx, xp, yp);
vzp = interp2 (x, z, vz, xp, yp);

xp +=vxp*dt;
yp +=vzp*dt;

  
end


t = linspace(0,2*pi,100)'; 

xc=a*cos(t);
zc=a*sin(t);

plot(xc,zc);

hold on

plot(x,z,'b*');

scale_factor = 0.03;

h = quiver (x,  z, vx*scale_factor, vz*scale_factor,'AutoScale','off');
axis([-3 3 -3 3])

