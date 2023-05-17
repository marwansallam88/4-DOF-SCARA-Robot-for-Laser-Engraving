clc();
t = [0:0.1:10];
n = length(t);
x = zeros(1,n);
y = zeros(1,n);
for k = 1:n
        x(1,k) = (0.228 * cos(sin(t(1,k)))) + (0.1365 * (cos(sin(t(1,k)) + sin(t(1,k)))));
        y(1,k) = (0.228 * sin(sin(t(1,k)))) + (0.1365 * (sin(sin(t(1,k)) + sin(t(1,k)))));
end
    hold on
    plot(t,x)
    plot(t,y)