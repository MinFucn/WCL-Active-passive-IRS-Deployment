
function [Rate_opt,x_AT] = Deployment_Single_Active(param)

%% Tx--AIRS-Rx

beta0 = param.beta0;
sigma_F = param.sigma_F; 
P_T = param.P_T; 
P_F = param.P_F; 
N_act = param.N_act; 
H_act = param.H_act; 
x_TR = param.x_BU;

x1 = sqrt(max(N_act*P_T*beta0/(P_F-N_act*sigma_F)-H_act^2,0)); Low_bound_AP = min(x1,x_TR);


fun = @(x)ComputingRate(param,x);

[x_AT,fun_val] = fminbnd(fun,Low_bound_AP,x_TR);

Rate_opt = -fun_val;

end

function [Rate_total] = ComputingRate(param,x)

%% Tx--AIRS-Rx
beta0 = param.beta0;
sigma = param.sigma;
sigma_F = param.sigma_F; 
P_T = param.P_T; 
P_F = param.P_F; 
N_act = param.N_act; 
H_act = param.H_act; 
x_TR = param.x_BU;

dis_tx_irs = x^2 + H_act^2;  dis_rx_irs = (x_TR-x)^2 + H_act^2;
PG_tx_irs = beta0/(dis_tx_irs); PG_rx_irs = beta0/(dis_rx_irs);
eta = sqrt(P_F/(PG_tx_irs*N_act*P_T + sigma_F*N_act));

SNR_num = eta^2*PG_tx_irs*PG_rx_irs*N_act^2*P_T;
SNR_den = eta^2*PG_rx_irs*N_act*sigma_F + sigma;

SNR = SNR_num/SNR_den;
Rate_total = -log2(1+SNR);


end

