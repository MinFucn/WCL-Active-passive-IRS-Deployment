
function [Rate_opt,x_tx_airs,eta] = Deployment_TPAR_b(param)

%% Tx--PIRS--AIRS-Rx

beta0 = param.beta0;
sigma = param.sigma;
sigma_F = param.sigma_F; 
P_T = param.P_T; 
P_F = param.P_F; 
N = param.N; 
N_act = param.N_act; 
N_pass = N-N_act;
H_act = param.H_act; 
H_pass = param.H_pass;
x_TR = param.x_BU;

x_tx_pirs = 0; dis_tx_pirs = x_tx_pirs^2 + H_pass^2;

x1 = sqrt(max(N_act*N_pass^2*P_T*beta0^2/(P_F-N_act*sigma_F)/dis_tx_pirs-(H_pass-H_act)^2,0));

Low_bound_AP = min(x1,x_TR);


fun = @(x)ComputingRate_TPAR_b(param,x);

[x_tx_airs,fun_val] = fminbnd(fun,Low_bound_AP,x_TR);
Rate_opt = -fun_val;


x_airs_pirs = x_tx_airs;  dis_airs_pirs = x_airs_pirs^2 + (H_act-H_pass)^2; 

PG_tx_pirs = beta0/(dis_tx_pirs); PG_airs_pirs = beta0/(dis_airs_pirs); 
eta = sqrt(P_F/(PG_tx_pirs*PG_airs_pirs*N_pass^2*N_act*P_T + N_act*sigma_F));



end


