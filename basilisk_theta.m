%X3cali = x3/sqrt(max(x3) + max(y3));Y3cali = y3/sqrt(max(x3^2) + max(y3^2));
x2 = 0; y2 = 0;
theta1 = 0; theta2 = 0;theta3 = 0;

l1 = 0.283; l2 = 0.275 ;l3 = 0.442; phi = 0;

for i = 1:32 
    phi(i) = atan(y3(i)/x3(i));
    x2(i) = x3(i) - l3*cos(phi(i)) ;
    y2(i) = y3(i) - l3*sin(phi(i)) ;
    leng = sqrt(x3(i)^2+y3(i)^2);
    r = sqrt(x2(i)^2 + y2(i)^2);
    disp('leng');
    disp(leng);
    disp('r');
    disp(r);
    theta1(i) = atan( y2(i)/x2(i) ) - acos( (l1^2 + r^2 - l2^2)/(2*l1*r) );
    disp('value')
    disp((l1^2 + r^2 - l2^2)/(2*l1*r));
    disp('cos')
    disp(acos( (l1^2 + r^2 - l2^2)/(2*l1*r) ))
    theta2(i) = pi - acos( (l1^2 + l2^2 - r^2)/(2*l1*l2) );
    theta3(i) = phi(i) - theta1(i) - theta2(i);
   

end

theta1 = theta1';theta2 = theta2';theta3 = theta3';
