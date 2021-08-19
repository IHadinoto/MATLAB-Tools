% option 1
len = 100;
x = 1:len;
y = rand(1,len);
figure(1); % bring figure to foreground
clf(); % clear figure
hold on;
plot(x(1), y(1)); %plot first part of the line
plot(x(1), y(1), '*'); % plot the first point
for i = 1:len
 figure(1); %make sure we are plotting on fig 1
 clf(); % why do we need this? try commenting it out
 hold on; % replot
 plot(x(1:i), y(1:i));
 plot(x(i), y(i), '*');
end