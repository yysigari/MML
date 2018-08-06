%% pseudo unites physiques

QT = 1.0e+05 *[  
    0.2365
    0.9591
    0.9219
    0.7287
    0.6047
   -0.9101
   -0.4035
    0.3438
    0.1997
   -0.1043
    0.1021
    0.4246
    0.3126
    0.1502
   -1.0329
   -0.1373
   -0.0604
    0.1522
    0.5029
   -0.0489
   -0.7860
    0.7093
   -0.0614
   -0.4356
   -0.5211
    1.0486
   -0.7618
   -0.2525
   -0.4964
    0.6276
    0.1071
    0.0339
    ]*1e-8;


%%
k= -900
%setsp('QT',k* QT + QT0, Mode,'Hardware');

%%

%% QT en ampere
QT = [
-0.2129
   -0.8632
   -0.8297
   -0.6558
   -0.5442
    0.8191
    0.3631
   -0.3094
   -0.1797
    0.0939
   -0.0919
   -0.3821
   -0.2813
   -0.1352
    0.9296
    0.1236
    0.0544
   -0.1370
   -0.4526
    0.0440
    0.7074
   -0.6384
    0.0553
    0.3920
    0.4690
   -0.9437
    0.6856
    0.2273
    0.4468
   -0.5648
   -0.0964
   -0.0305
];

setsp('QT',QT, 'Hardware');