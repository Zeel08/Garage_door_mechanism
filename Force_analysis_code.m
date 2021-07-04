l1 = 0.75;
l2 = 3.4;
l3 = 1.3;
l4 = 3;

% lengths of position of weights from the hinge of 

l3_ = 1.75;
l2_ = 3.4/2;
l4_ = 3/2;

th1 = 9;

% for storing the path

arr_px = [];
arr_py = [];
arr_qx = [];
arr_qy = [];

d_hmax = 0;
d_vmax = 0;

% for calculating the angular velocity:

th2_prev = 0;
th3_prev = 0;
th4_prev = 0;

% anugular velocities

w2 = 0;
w4 = 0;
w3 = 0;

% for time period for calculation of angular velocies

t = 0 ;

%weights of links

wht1 = NaN; % ground
wht2 = 2.6;
wht3 = 75;
wht4 = 6;

torque_req = [];

for th3 = cat(2,linspace(0,90,90),fliplr(linspace(0,90,90)))
ani = subplot(1,2,1);

a = -2*l4*l3*cosd(th3) + 2*l1*l4*cosd(th1);
b = -2*l4*l3*sind(th3) + 2*l1*l4*sind(th1);
c = l1^2 + l3^2 + l4^2 - l2^2 - 2*l1*l3*cosd(th3-th1);

value1 = 2*atand((-b+sqrt(b^2 + a^2 - c^2))/(c-a));
value2 = 2*atand((-b-sqrt(b^2 + a^2 - c^2))/(c-a));

p = 2*l2*l3*cosd(th3) - 2*l1*l2*cosd(th1);
q = 2*l2*l3*sind(th3) - 2*l1*l2*sind(th1);
r = l1^2 + l2^2 + l3^2 - l4^2 - 2*l1*l3*cosd(th3-th1);

value3 = 2*atand((-q+sqrt(q^2 + p^2 - r^2))/(r-p));
value4 = 2*atand((-q-sqrt(q^2 + p^2 - r^2))/(r-p));

th4 = value1;
th2 = value4;

if th3 ~= 0
 t = toc;
end

tic 

plot([0 l1*cosd(th1)],[0 l1*sind(th1)],'r-*') % l1

hold on


plot([0 l2*cosd(th2)],[0 l2*sind(th2)],'b-*') % l2

plot([l2*cosd(th2)-2.2*cosd(th3) l2*cosd(th2) l2*cosd(th2)+l3*cosd(th3) l2*cosd(th2)+l3*cosd(th3)+4.5*cosd(th3)],[l2*sind(th2)-2.2*sind(th3) l2*sind(th2) l2*sind(th2)+l3*sind(th3) l2*sind(th2)+l3*sind(th3)+4.5*sind(th3)],'g-.*') % l3 -> floating bar


plot([l1*cosd(th1) l1*cosd(th1)+l4*cosd(th4)],[l1*sind(th1) l1*sind(th1)+l4*sind(th4)],'k-.*') % l4

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

 d_hmax = abs(l2*cosd(th2)-2.2*cosd(th3));

end


if th3 ~= 0

 w2 = (th2 - th2_prev)/t;

 % to check with the values calculated using formula

 w_check3 = (th3 - th3_prev)/t;
 w_check4 = (th4 - th4_prev)/t;

end

 
th2_prev = th2;
th3_prev = th3;
th4_prev = th4;


e1 = -l4*(l1*sind(th1 - th4) + l2*sind(th4 - th2));
e2 = l2*(l1*sind(th2 - th1) + l4*sind(th2 - th4));

j24 = (e2/e1);

%w2 = w4*(e1/e2)

w4 = w2*j24;

e3 = -l2*(l3*sind(th3 - th2) + l1*sind(th2 - th1));
e4 = l3*(l2*sind(th2 - th3) + l1*sind(th3 - th1));

j23 = (e3/e4);

w3 = w2*j23;

pause(0.1)

l1*sind(th1) + (l4/2)*sind(th4);

if th3 >= 0

 ani = subplot(1,2,2);
 plot(torque_req,'g-*');
 title('Force Analysis');
 xlabel('Time'); 
 ylabel('Torque required');

end


torque_req(end+1) = -(wht2*(l2_) +wht3*l2)*cosd(th2) - j23*wht3*l3_*cosd(th3) - j24*wht4*l4_*cosd(th4);

%axis(gca,'equal');
%axis([-10 18 -10 15]);


end

hold on 

plot([arr_px(1) arr_qx(1)],[arr_py(1) arr_qy(1)],'g-*')
d_vmax - arr_qy(1)
d_hmax - abs(arr_px(end))