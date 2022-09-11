a=1;
v0=10 ;
N=40; % number of points in the grid
l=1;


xx=linspace(-3,3,N); % x component

zz=linspace(-3,3,N);


[x,z]=meshgrid(xx,zz);

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


xp=-1.3;
zp=-0;

vxp = interp2 (x, z, vx, xp, zp,'spline')
vzp = interp2 (x, z, vz, xp, zp,'spline')

mesh(xx,zz,0.03*vz)

hold on
plot3(xp, zp, 0.03*vzp,'b*');