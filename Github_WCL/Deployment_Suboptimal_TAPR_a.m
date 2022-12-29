
function [Rate_TAPR,x_AT,x2] = Deployment_Suboptimal_TAPR_a(param)

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


x_rx_pirs = 0; dis_rx_pirs = x_rx_pirs^2 + H_pass^2;


C1 = sigma_F*P_F*beta0*N_pass^2;
C2 = sigma*P_T*H_pass^2;

x2 = sqrt(max(0,N_act*P_T*beta0/(P_F-N_act*sigma_F)-H_act^2));


x_AT_1 = C2/(C1+C2)*x_TR; x_AT = max(x_AT_1,x2);


x_AP = x_TR-x_rx_pirs-x_AT; dis_AT = x_AT^2 + H_act^2; dis_AP = x_AP^2 + (H_act-H_pass)^2; 

%dis_AT = x_AT^2 ; dis_AP = x_AP^2 ; 

Rate_TAPR = log2(1+beta0^2*N_act*N_pass^2*P_T*P_F/(C1*dis_AT + C2*dis_AP));


end


