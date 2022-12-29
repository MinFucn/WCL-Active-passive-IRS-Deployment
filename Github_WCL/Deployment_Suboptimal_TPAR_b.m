
function [Rate_TPAR,x_AP,x1] = Deployment_Suboptimal_TPAR_b(param)

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

x_PT = 0;
x_TR = param.x_BU;
dis_PT = x_PT^2 + H_pass^2;


C1 = sigma*beta0*N_pass^2*P_T;
C2 = sigma_F*H_pass^2*P_F;
C3 = H_pass^2*sigma*sigma_F/beta0;



x1 = sqrt(max(0,N_act*N_pass^2*P_T*beta0^2/(P_F-N_act*sigma_F)/dis_PT-(H_pass-H_act)^2));
x_AP_1 = C1/(C1+C2)*x_TR;

x_AP = max(x_AP_1,x1 );


x_AR = x_TR-x_PT-x_AP;

dis_AR = x_AR^2 + H_act^2;  dis_AP = x_AP^2 + (H_act-H_pass)^2; 


Rate_TPAR = log2(1+beta0^2*N_act*N_pass^2*P_T*P_F/(C1*dis_AR + C2*dis_AP));


end


