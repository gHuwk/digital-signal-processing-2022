

% Исходные параметры
sigma = 5;
tt = 2;

% Дискретные сигналы
n = input('Число семплов: ');
dt = input('Шаг: ');
t_max = dt*(n-1)/2;
t = -t_max:dt:t_max; 

gauss_discrete = exp(-(t/sigma).^2);
rect_discrete = zeros(size(t));
rect_discrete(abs(t) - tt < 0) = 1;

% Исходные сигналы
x = -t_max:0.005:t_max;
% Сигнал Гаусса U(x) = Aexp(-(x/sigma)^2), A = 1, sigma = [1,2]
gauss_ref = exp(-(x/sigma).^2);
% Прямоугольный импульс U(x) = rect(x/L), L = [1,3]
% rect(x) = 1, if |x| <= 1
% rect(x) = 0, other
rect_ref = zeros(size(x));
rect_ref(abs(x) - tt < 0) = 1;

% Восстановленные сигналы
% sinc(x) = sin(x) / x
function return_v = my_sinc(x, dt)
    if t == 0
        return_v = 1;
    else
        return_v = sin(x / dt * pi) / dt * pi;
end

% F = 1 / 2 dx
gauss_restored = zeros(1, length(x));
rect_restored = zeros(1, length(x));
for i=1:length(x)
   for j = 1:n
       % Через формулу Котельникова
       gauss_restored(i) = gauss_restored(i) + gauss_discrete(j) * my_sinc(x(i) - t(j), dt);
       rect_restored(i) = rect_restored(i) + rect_discrete(j) * my_sinc(x(i) - t(j), dt);
   end
end


figure;

subplot(2,1,1);
title('Прямоугольный импульс');
hold on;
grid on;
plot(x, rect_ref, 'k');
plot(x, rect_restored, 'b');
plot(t, rect_discrete, '.m');
legend('Исходная', 'Восстановленная', 'Дискретная');

subplot(2,1,2);
title('Гауссовский фильтр');
hold on;
grid on;
plot(x, gauss_ref, 'k');
plot(x, gauss_restored, 'b');
plot(t, gauss_discrete, '.m');
legend('Исходная', 'Восстановленная', 'Дискретная');
