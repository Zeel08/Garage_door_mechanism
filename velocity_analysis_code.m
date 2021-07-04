l1 = 0.75;
l2 = 3.4;
l3 = 1.3;
l4 = 3;

th1 = 9;
% for storing the path
arr_px = [];
arr_py = [];

arr_qx = [];
arr_qy = [];

arr_pv = [];


d_hmax = 0;

d_vmax =  0;
t = -1;

for th3 = cat(2,linspace(0,90,90),fliplr(linspace(0,90,90)))

 

ani = subplot(1,2,1);

 

%For theta 4
a = -2*l4*l3*cosd(th3) + 2*l1*l4*cosd(th1);
b = -2*l4*l3*sind(th3) + 2*l1*l4*sind(th1);
c = l1^2 + l3^2 + l4^2 - l2^2 - 2*l1*l3*cosd(th3-th1);

 

value1 = 2*atand((-b+sqrt(b^2 + a^2 - c^2))/(c-a));
value2 = 2*atand((-b-sqrt(b^2 + a^2 - c^2))/(c-a));

 

%For theta 2

 

p = 2*l2*l3*cosd(th3) - 2*l1*l2*cosd(th1);
q = 2*l2*l3*sind(th3) - 2*l1*l2*sind(th1);
r = l1^2 + l2^2 + l3^2 - l4^2 - 2*l1*l3*cosd(th3-th1);

 

value3 = 2*atand((-q+sqrt(q^2 + p^2 - r^2))/(r-p));
value4 = 2*atand((-q-sqrt(q^2 + p^2 - r^2))/(r-p));

 

th4 = value1;
th2 = value4;

 


plot([0 l1*cosd(th1)],[0 l1*sind(th1)],'r-*') % l1
hold on
plot([0 l2*cosd(th2)],[0 l2*sind(th2)],'b-*') % l2
plot([l2*cosd(th2)-2.2*cosd(th3) l2*cosd(th2) l2*cosd(th2)+l3*cosd(th3) l2*cosd(th2)+l3*cosd(th3)+4.5*cosd(th3)],[l2*sind(th2)-2.2*sind(th3) l2*sind(th2) l2*sind(th2)+l3*sind(th3) l2*sind(th2)+l3*sind(th3)+4.5*sind(th3)],'g-.*') % l3 -> floating bar
plot([l1*cosd(th1) l1*cosd(th1)+l4*cosd(th4)],[l1*sind(th1) l1*sind(th1)+l4*sind(th4)],'k-.*') % l4
title('Displacement Analysis');
xlabel('X position'); 
ylabel('Y position');
 

% for path points
plot(arr_px,arr_py,'m *')
plot(arr_qx,arr_qy,'y *')
hold off

 

arr_px(end + 1) = l2*cosd(th2)-2.2*cosd(th3);
arr_py(end + 1) = l2*sind(th2)-2.2*sind(th3);

 

arr_qx(end + 1) = l2*cosd(th2)+l3*cosd(th3)+4.5*cosd(th3);
arr_qy(end + 1) = l2*sind(th2)+l3*sind(th3)+4.5*sind(th3);

 

% calculating the maximum distance of point p from vertical and q from horizontal
if d_vmax < l2*sind(th2)+l3*sind(th3)+4.5*sind(th3)
    d_vmax = l2*sind(th2)+l3*sind(th3)+4.5*sind(th3);
end


if d_hmax < abs(l2*cosd(th2)-2.2*cosd(th3))
   d_hmax =  abs(l2*cosd(th2)-2.2*cosd(th3));
end

 

if (th3>=1 && th3 < 89)
    px_v =(arr_px(end) - arr_px(end-1))/1;
end


if (th3>=1 && th3 < 89)
    py_v =( arr_py(end) - arr_py(end-1))/1;
end

 

if (th3>=1 && th3 < 89)
    pv = sqrt( (py_v)^2 + (px_v)^2);
    arr_pv(end+1) = pv;
    
end
%pv
if (th3>2 && th3 < 89)
    ani = subplot(1,2,2);
    plot(arr_pv,'g-*')
    title('Velocity Analysis');
    xlabel('Time'); 
    ylabel('Velocity'); 
end

 


pause(0.1)
 

end
d_vmax = d_vmax - arr_qy(1)
d_hmax = d_hmax - abs(arr_px(end))
