
function [Rate_opt,X_tx_airs,eta] = Deployment_TAPR_a(param)

%% Tx--AIRS--PIRS-Rx

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


x2 = sqrt(max(0,N_act*P_T*beta0/(P_F-N_act*sigma_F)-H_act^2)); low_bound_AP = min(x2,x_TR);


fun = @(x)ComputingRate_TAPR_a(param,x);
[X_tx_airs,fun_val] = fminbnd(fun,low_bound_AP,x_TR);
Rate_opt = -fun_val;


dis_tx_airs = X_tx_airs^2 + H_act^2; PG_tx_airs = beta0/dis_tx_airs;
eta = sqrt(P_F/(PG_tx_airs*N_act*P_T + N_act*sigma_F));
end


