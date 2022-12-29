function [Rate] = ComputingRate_TAPR_a(param,x_tx_airs)

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

x_rx_pirs = 0; x_airs_pirs = x_TR-x_rx_pirs-x_tx_airs;

dis_tx_airs = x_tx_airs^2 + H_act^2; dis_airs_pirs = x_airs_pirs^2 + (H_act-H_pass)^2; 
dis_rx_pirs = x_rx_pirs^2 + H_pass^2;


PG_tx_airs = beta0/(dis_tx_airs); PG_airs_pirs = beta0/(dis_airs_pirs);  PG_rx_pirs = beta0/(dis_rx_pirs);

eta = sqrt(P_F/(PG_tx_airs*N_act*P_T + N_act*sigma_F));

SNR_num = eta^2*PG_tx_airs*PG_airs_pirs*PG_rx_pirs*N_act^2*N_pass^2*P_T;

SNR_den  = eta^2*PG_airs_pirs*PG_rx_pirs*N_act*N_pass^2*sigma_F + sigma;

SNR = SNR_num/SNR_den;
Rate = -log2(1+SNR);

end
