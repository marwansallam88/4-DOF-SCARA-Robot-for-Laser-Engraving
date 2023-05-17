clc;clear all;

%5. Transfer Function

A = [0 0 1 0; 0 0 0 1; 0 0 -29.60902125 68.58635402; 0 0 68.58635402 68.58635402];
B = [0 0; 0 0; -29.60902125 68.58635402; 68.58635402 68.58635402];
C = [1 0 0 0; 0 1 0 0];
D = [0 0; 0 0];
sys = ss(A,B,C,D);
[o,i] = ss2tf(A,B,C,D,2);
disp(o);
systf = tf(sys);
%step(systf(1,1));
%step(systf(2,1));
%6. State Space Representation

[a,b,c,d] = tf2ss(o,i)

%7. Requirements from step response

S = stepinfo(systf)

%8. Eigenvalues and Eigenvectors of a matrix

[V,DI] = eig(a)

%9. Stability

ST = isstable(sys)
display("System is stable as all eigenvalues(poles of system) are negative(in the left hand plane)")

%10. State response, x1, x2

t = 0:1:20;
u = ones(1,length(t));
x0 = [0;1];
w0 = inv(V)*x0
Ah = inv(V)*a*V
Bh = inv(V)*b
n = length(t);
x1 = zeros(1,n);
x2 = zeros(1,n);
%x1

for k = 1:n
    x1(1,k) = -0.3536*exp(-1.7071*t(1,k)) + 0.3535*exp(-0.2929*t(1,k)) + 3.95*10^-5;
end
subplot(3,1,1);
plot(t,x1,'-r')
grid on
xlabel('time(sec)')
ylabel('amplitude')
legend('x1')
title('x1 solution')

%x2

for k = 1:n
    x2(1,k) = 0.2071*exp(-1.7071*t(1,k)) + -1.207*exp(-0.2929*t(1,k)) + 2;
end
subplot(3,1,2); 
plot(t,x2,'-g')
grid on
xlabel('time(sec)')
ylabel('amplitude')
legend('x2')
title('x2 solution')

%State response

subplot(3,1,3);
plot(t,lsim(sys,u,t,x0,'-b'))
grid on
xlabel('time(sec)')
ylabel('amplitude')
legend('State response')
title('State response for step input for given initials')

%11. Controllability and Observability

%Controllability

Co = ctrb(a,b)
rank(Co)
unco = length(a) - length(Co)
display("System fully controllable as there are zero uncrontrollabe states")
display("As well Co rank is non zero/fully ranked")

%Observability

Ob = obsv(a,c)
rank(Ob)
display("System fully observable as there are zero observable states")
display("As well Ob rank is non zero/fully ranked")

%12. Feedback Controller

p = [-5 -7];

%Method 1

K1 = place(a,b,p)

%Method 2

K2 = acker(a,b,p)

Ac = a-b*K1;
Bc = b;
Cc = c;
Dc = d;
sys_closed = ss(Ac,Bc,Cc,Dc)



