
function [Rate_opt,X_tx_irs] = Deployment_Single_passive(param)

%% Tx--PIRS--Rx

beta0 = param.beta0;
sigma = param.sigma;
P_T = param.P_T; 
P_F = param.P_F; 
N = param.N;
H_pass = param.H_pass; 
x_TR = param.x_BU; % Tx-Rx distance


%% near-optimal solution
X_tx_irs = 0;
dis_tx_irs = H_pass^2;  dis_rx_irs = x_TR^2 + H_pass^2;
PG_tx_irs = beta0/(dis_tx_irs); PG_rx_irs = beta0/(dis_rx_irs);
SNR_near = PG_tx_irs*PG_rx_irs*N^2*(P_T+P_F)/sigma;
Rate_near = log2(1+SNR_near);
%% optimal solution
Low_bound_AP = 0; 
fun = @(x)ComputingRate(param,x);
[X_tx_irs,fun_val] = fminbnd(fun,Low_bound_AP,x_TR); 
Rate_opt = -fun_val;
end

function [Rate_total] = ComputingRate(param,x)

beta0 = param.beta0;
sigma = param.sigma;
P_T = param.P_T; 
P_F = param.P_F; 
N = param.N; 
H_pass = param.H_pass; 
x_TR = param.x_BU; 


dis_tx_irs = x^2 + H_pass^2;  dis_rx_irs = (x_TR-x)^2 + H_pass^2;
PG_tx_irs = beta0/(dis_tx_irs); PG_rx_irs = beta0/(dis_rx_irs);

SNR_DL = PG_tx_irs*PG_rx_irs*N^2*(P_T+P_F)/sigma;
Rate_total = -log2(1+SNR_DL);
end