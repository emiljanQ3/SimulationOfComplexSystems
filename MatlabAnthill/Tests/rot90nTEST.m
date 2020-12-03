addpath("../")

x = [1:5;1:5];
y = [ones(1,5)*1;2*ones(1,5)];
plot(x,y,'*r'); hold on;
[xr,yr] =  rot90n(x,y,1);
plot(xr,yr,'*b');
[xr2,yr2] =  rot90n(x,y,2);
plot(xr2,yr2,'*g')
[xr3,yr3] =  rot90n(x,y,3);
plot(xr3,yr3,'*c')
axis([-5 5 -5 5])

figure(2)
x = [1:5;1:5];
y = [ones(1,5)*1;2*ones(1,5)];
plot(x,y,'*r'); hold on;
[xr,yr] =  rot90n(x,y,-1);
plot(xr,yr,'*b');
[xr2,yr2] =  rot90n(x,y,-2);
plot(xr2,yr2,'*g')
[xr3,yr3] =  rot90n(x,y,-3);
plot(xr3,yr3,'*c')
axis([-5 5 -5 5])


