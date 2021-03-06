aspsr_v2simple;

deletemisalign;
clear max_amplitude_x max_amplitude_y x_factor_ind y_factor_ind
iterations = 5;
x_error = 0.5e-6;
y_error = 0.5e-6;

% Uses markers to define girders
setgirdermisalign('g1m1','g1m2',[x_error 0 y_error 0 0 0],0);
setgirdermisalign('g2m1','g2m2',[x_error 0 y_error 0 0 0],0);
setgirdermisalign('dipm1','dipm2',[x_error 0 y_error 0 0 0],0);

% setmisalign(7,[x_error 0 y_error 0 0 0],0);


calcmisalign(iterations,'sho');

for i=1:iterations
    applymisalign;
    Orb = findorbit4(THERING,0,1:length(THERING)+1);
%     max_amplitude_x(i) = max(abs(Orb(1,:)));
%     max_amplitude_y(i) = max(abs(Orb(3,:)));
    max_amplitude_x(i) = sqrt(sum(Orb(1,:).^2));
    max_amplitude_y(i) = sqrt(sum(Orb(3,:).^2));
    %     max_amplitude_x(i) = max(Orb(1,:));
    %     max_amplitude_y(i) = max(Orb(3,:));
end

% x_factor = mean(max_amplitude_x/(2*x_error));
% y_factor = mean(max_amplitude_y/(2*y_error));

% mis = getappdata(0,'MisalignData');
% for i=1:iterations
%     x_factor_ind(i) = max_amplitude_x(i)/mean(abs(mis.applied(i).deltax(find(mis.applied(i).deltax > 0))));
%     y_factor_ind(i) = max_amplitude_y(i)/mean(abs(mis.applied(i).deltay(find(mis.applied(i).deltay > 0))));
% end
% x_factor = mean(x_factor_ind)
% y_factor = mean(y_factor_ind)

mis = getappdata(0,'MisalignData');
for i=1:iterations
    x_factor_ind(i) = max_amplitude_x(i)/sqrt(sum(mis.applied(i).deltax(find(abs(mis.applied(i).deltax) > 0)).^2));
    y_factor_ind(i) = max_amplitude_y(i)/sqrt(sum(mis.applied(i).deltay(find(abs(mis.applied(i).deltay) > 0)).^2));
end
x_factor = mean(x_factor_ind)
y_factor = mean(y_factor_ind)