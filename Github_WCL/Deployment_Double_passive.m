
function [Rate_near,x_pirs_pirs] = Deployment_Double_passive(param)



beta0 = param.beta0;
sigma = param.sigma;
P_T = param.P_T; 
P_F = param.P_F; 
N = param.N; 
x_TR = param.x_BU;
H_act = param.H_act; H_pass = param.H_pass;


%% near-optimal solution

x_pirs_pirs = x_TR;
dis_tx_pirs = H_act^2; dis_pirs_pirs = x_TR^2 + (H_act-H_pass)^2 ; dis_rx_pirs = H_pass^2;

PG_tx_pirs = beta0/(dis_tx_pirs); PG_pirs_pirs = beta0/(dis_pirs_pirs);  PG_rx_pirs = beta0/(dis_rx_pirs);

SNR_near = PG_tx_pirs*PG_pirs_pirs*PG_rx_pirs*(N/2)^4*(P_T+P_F)/sigma;
Rate_near = log2(1+SNR_near);


end

