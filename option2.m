% option 2
len = 100;
x = 1:len;
y = rand(1,len);
figure(2);
clf();
hold on;
line = plot(x(1), y(1));
point = plot(x(1), y(1), '*');
for i2 = 1:len
 set(line, 'XData', x(1:i2), 'YData', y(1:i2));
 set(point, 'XData', x(i2), 'YData', y(i2));
 pause(0.01); % needed or you dont see the loop
end