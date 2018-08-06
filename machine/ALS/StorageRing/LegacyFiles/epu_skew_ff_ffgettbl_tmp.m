function Qcurr = epu_skew_ff_ffgettbl(Sector, gap, shift)
% function Qcurr = epu_skew_ff_ffgettbl(Sector, gap, shift)
%
% 10 Hz skew feedforward for EPUs in sector 4+11
% Christoph Steier, 2004-08-10

% Changed to a function to call from feedforward table generation routines
% T. Scarvie, 2005-02-03
% function Qcurr = epu_skew_ff_ffgettbl(Sector, gap, shift)

% load('/home/als/physbase/matlab/als/alsdata/epu_skew_tables_20040805.mat');

% SR4+11 epu skew quadrupole feed forward             
% scale= -0.06;    % for nu_y = 8.20 lattice
% scale4 = -0.063*5/18;  % this factor changed after 3-22-05 skew coil work
% -0.063*5/18 = -0.0175
% based on orbit response matrrix measurement 2005-03-28/12-50 + 13-16
scale4 = -0.0157;
%scale11 = -0.063;  %scale factor changed after April 05 shutdown wiring correction
scale11 = -0.0135;
vertscale = 0.85;

epu4_skew_verttable=[2.1000000e+002  1.5000000e+002  1.0000000e+002  5.0000000e+001  4.0000000e+001  ...
    2.5000000e+001  1.8000000e+001  1.4900000e+001; ...
    0.0000000e+000  0.0000000e+000  0.0000000e+000  0.0000000e+000  0.0000000e+000 ...
    -2.2176536e+001 -1.6124256e+002 -2.6721081e+002];

epu4_skew_scaletable_antiparallel=[2.1000000e+002  1.5000000e+002  1.0000000e+002  5.0000000e+001  ...
    4.0000000e+001  2.5000000e+001  1.8000000e+001  1.4900000e+001; ...
    0.0000000e+000  0.0000000e+000  0.0000000e+000  0.0000000e+000  0.0000000e+000 ...
    2.1400531e-001  6.2632065e-001  1.0000000e+000];

epu4_skew_scaletable_parallel=[2.1000000e+002  1.5000000e+002  1.0000000e+002  5.0000000e+001  ...
    4.0000000e+001  2.5000000e+001  1.8000000e+001  1.4900000e+001; ...
    0.0000000e+000  0.0000000e+000  0.0000000e+000  0.0000000e+000  0.0000000e+000 ...
    4.9585496e-001  8.2464550e-001  1.0000000e+000];

epu4_skew_table_antiparallel=[-2.5000000e+001 -2.0000000e+001 -1.5000000e+001 -1.0000000e+001 -5.0000000e+000 ...
 0.0000000e+000  5.0000000e+000  1.0000000e+001  1.5000000e+001  2.0000000e+001  2.5000000e+001; ...
-8.4776790e+001 -1.1715685e+002 -9.5414671e+001 -1.2525239e+002 -2.1084633e+002 ...
-2.6721081e+002 -1.7757497e+002 -3.1660694e+001  2.1874780e+001 -3.6665803e+001 ...
-1.0234696e+002];

epu4_skew_table_parallel=[-2.5000000e+001 -2.0000000e+001 -1.5000000e+001 -1.0000000e+001 -5.0000000e+000 ...
    0.0000000e+000  5.0000000e+000  1.0000000e+001  1.5000000e+001  2.0000000e+001  2.5000000e+001; ...
-9.8240629e+001 -4.7482357e+001 -5.8497844e+001 -9.4927397e+001 -1.8758425e+002 ...
-2.9714928e+002 -3.5093796e+002 -3.1911536e+002 -2.9009576e+002 -2.1576943e+002 ...
-1.0850574e+002];


if Sector ~= 4 & Sector ~= 11
   disp('  No EPU in that Sector!!');
   return
end

%gap = getid(Sector);
%         [gapmin,gapmax] = gaplimit(Sector);
%         if gap < (gapmin-1)
%            gap = gapmax;
%         end  
%shift = getepu(Sector);

if Sector == 4
   mode = scaget('SR04U___ODS1M__DC00');
   curr4 = 0;
   if mode == 0
      curr4=scale4.*(vertscale.*interp1(epu4_skew_verttable(1,:),epu4_skew_verttable(2,:),gap,'linear','extrap') ...
          + interp1(epu4_skew_scaletable_parallel(1,:),epu4_skew_scaletable_parallel(2,:),gap,'linear','extrap') ...
          .* (interp1(epu4_skew_table_parallel(1,:),epu4_skew_table_parallel(2,:),shift,'spline','extrap') ... 
          - interp1(epu4_skew_table_parallel(1,:),epu4_skew_table_parallel(2,:),0,'spline','extrap')));
   elseif mode == 1
      curr4=scale4.*(vertscale.*interp1(epu4_skew_verttable(1,:),epu4_skew_verttable(2,:),gap,'linear','extrap') ...
          + interp1(epu4_skew_scaletable_antiparallel(1,:),epu4_skew_scaletable_antiparallel(2,:),gap,'linear','extrap') ...
          .* (interp1(epu4_skew_table_antiparallel(1,:),epu4_skew_table_antiparallel(2,:),shift,'spline','extrap') ... 
          - interp1(epu4_skew_table_antiparallel(1,:),epu4_skew_table_antiparallel(2,:),0,'spline','extrap')));
   end
   Qcurr = curr4;
   
elseif Sector == 11
   mode = scaget('SR11U___ODS2M__DC00');
   curr11 = 0;
   if mode == 0
      curr11=scale11.*(vertscale.*interp1(epu11_skew_verttable(1,:),epu11_skew_verttable(2,:),gap,'linear','extrap') ...
          + interp1(epu11_skew_scaletable_parallel(1,:),epu11_skew_scaletable_parallel(2,:),gap,'linear','extrap') ...
          .* (interp1(epu11_skew_table_parallel(1,:),epu11_skew_table_parallel(2,:),shift,'spline','extrap') ... 
          - interp1(epu11_skew_table_parallel(1,:),epu11_skew_table_parallel(2,:),0,'spline','extrap')));
   elseif mode == 1
      curr11=scale11.*(vertscale.*interp1(epu11_skew_verttable(1,:),epu11_skew_verttable(2,:),gap,'linear','extrap') ...
          + interp1(epu11_skew_scaletable_antiparallel(1,:),epu11_skew_scaletable_antiparallel(2,:),gap,'linear','extrap') ...
          .* (interp1(epu11_skew_table_antiparallel(1,:),epu11_skew_table_antiparallel(2,:),shift,'spline','extrap') ... 
          - interp1(epu11_skew_table_antiparallel(1,:),epu11_skew_table_antiparallel(2,:),0,'spline','extrap')));
   end
   Qcurr = curr11;

end