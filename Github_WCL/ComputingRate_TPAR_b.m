
function [Rate] = ComputingRate_TPAR_b(param,x_tx_airs)


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



x_tx_pirs = 0; x_airs_pirs = x_tx_airs;  x_rx_airs = x_TR-x_airs_pirs-x_tx_pirs;

dis_tx_pirs = x_tx_pirs^2 + H_pass^2; dis_airs_pirs = x_airs_pirs^2 + (H_act-H_pass)^2; 
dis_rx_airs = x_rx_airs^2 + H_act^2; 

PG_tx_pirs = beta0/(dis_tx_pirs); PG_airs_pirs = beta0/(dis_airs_pirs);  PG_rx_airs = beta0/(dis_rx_airs);

eta = sqrt(P_F/(PG_tx_pirs*PG_airs_pirs*N_pass^2*N_act*P_T + N_act*sigma_F));

SNR_num = eta^2*PG_tx_pirs*PG_airs_pirs*PG_rx_airs*N_act^2*N_pass^2*P_T;
SNR_den  = eta^2*PG_rx_airs*N_act*sigma_F + sigma;

SNR = SNR_num/SNR_den;
Rate = -log2(1+SNR);

end
