

RGBmatrix = [            
              178, 50, 75; %light red
              255,192,0; % yellon 
              4, 20, 123; %blue                         
              116,52,129;%purple 
              61.2,145,63.75;  %green
              0, 0, 0;  %black
              10.2, 22.95, 68.85; %dark blue
              168,26,22; %red
               ]/255;             
                           

           
x_BU = 30;
beta0 = db2pow(-43);
sigma = db2pow(-80)/10^3;
sigma_F = sigma*4; 
P_F = db2pow(4)/10^3; 
P_T = db2pow(20)/10^3; 

H_pass = 5;  H_act = H_pass+1;
N_pass = 600; N_act = 450; N = N_pass+N_act;
x_PB = x_BU*0; dis_PB = x_PB^2 + H_pass^2;
param.x_PB = x_PB;
param.x_BU = x_BU;
param.beta0 = beta0;
param.sigma = sigma;
param.sigma_F = sigma_F; 
param.P_T = P_T; 
param.P_F = P_F; 
param.N = N; 
param.N_act = N_act; 
param.N_pass = N_pass; 
param.H_act = H_act; 
param.H_pass = H_pass;
