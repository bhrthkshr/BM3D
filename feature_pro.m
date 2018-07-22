function [out] = feature_pro(in)
size_1 = size(in,1); 
size_2 = size(in,2); 
size_3 = size(in,3);
 
out.autoc = zeros(1,size_3); % Autocorrelation 1
out.contr = zeros(1,size_3); % Contrast  2
out.corrm = zeros(1,size_3); % Correlation  3
out.corrp = zeros(1,size_3); % Correlation  4
out.entro = zeros(1,size_3); % Entropy   5
out.sosvh = zeros(1,size_3); % Sum of sqaures: Variance  6
out.savgh = zeros(1,size_3); % Sum average 7
out.senth = zeros(1,size_3); % Sum entropy  8
out.dvarh = zeros(1,size_3); % Difference variance  9
out.denth = zeros(1,size_3); % Difference entropy  10
out.inf1h = zeros(1,size_3); % Information measure of correlation1  11
out.inf2h = zeros(1,size_3); % Informaiton measure of correlation2  12
out.indnc = zeros(1,size_3); % Inverse difference normalized (INN)  1
out.idmnc = zeros(1,size_3); % Inverse difference moment normalized 
% ransforming the domain specified by vectors x and y into arrays X and Y,
% to be used for evaluating functions of two variables
[i,j] = meshgrid(1:size_1,1:size_2); 
id_x1 = (i+j)-1; 
id_x2 = abs(i-j)+1; 
ii_1 = (1:(2*size_1-1))'; 
jj_1 = (0:size_1-1)';

for k = 1:size_3 % number glcms 
    % Normalize GLCM for computation efficiency 
    glcm_sum = sum(sum(in(:,:,k))); 
    P_ij = in(:,:,k)./glcm_sum ;% Normalize each glcm 
    m_mean = mean(P_ij(:)); % compute mean after norm 
    % 
    pik_x = squeeze(sum(P_ij,2)); %Removes singleton dimensions and Two-dimensional arrays are unaffected by squeeze
    pik_y = squeeze(sum(P_ij,1))'; 
    % 
    u_xk = sum(sum(i.*P_ij)); 
    u_yk = sum(sum(j.*P_ij)); 
    % 
    p_xply = zeros((2*size_1 - 1),1); % initializing with zero of size 2*glcm1 size and one column
    p_xminy = zeros((size_1),1); %
    for aux = 1:max(id_x1(:))  % checking condition for computing for idx1 and idx2
       p_xply(aux) = sum(P_ij(id_x1==aux)); %if idx1 then save it variable  
    end 
    for aux = 1:max(id_x2(:)) 
       p_xminy(aux) = sum(P_ij(id_x2==aux)); % if idx2 save it for other variable
    end 
   
    % Contrast 
    out.contr(k) = sum(sum((abs(i-j).^2).*P_ij)); 
    % Entropy 
    out.entro(k) = -sum(sum(P_ij.*log(P_ij+eps))); 
      % Sum of squares: Variance 
    out.sosvh(k) = sum(sum(P_ij.*((j-m_mean).^2))); 
    % Inverse difference normalized 
    out.indnc(k) = sum(sum(P_ij./(1+(abs(i-j)./size_1)))); 
    % Inverse difference moment normalized 
    out.idmnc(k) = sum(sum(P_ij./(1+((i-j)./size_1).^2))); 
     % Sum average 
    out.savgh(k) = sum((ii_1+1).*p_xply); 
    % Sum entropy 
    out.senth(k) = -sum(p_xply.*log(p_xply+eps)); 
     % Difference entropy 
    out.denth(k) = -sum(p_xminy.*log(p_xminy+eps)); 
    % Difference variance 
    out.dvarh(k) = sum((jj_1.^2).*p_xminy); 
    % Computes correlation 
    hxy1 = -sum(sum(P_ij.*log(pik_x*pik_y' + eps))); 
    hxy2 = -sum(sum((pik_x*pik_y').*log(pik_x*pik_y' + eps))); 
    hx = -sum(pik_x.*log(pik_x+eps)); 
    hy = -sum(pik_y.*log(pik_y+eps)); 
    hxy = out.entro(k); 
    % Information measure of correlation 1 
    out.inf1h(k) = (hxy-hxy1)/(max([hx,hy])); 
    % Information measure of correlation 2 
    out.inf2h(k) = (1-exp(-2*(hxy2-hxy)))^0.5; 
      % Autocorrelation 
    s_x = sum(sum(P_ij.*((i-u_xk).^2)))^0.5; 
    s_y = sum(sum(P_ij.*((j-u_yk).^2)))^0.5; 
    corp = sum(sum(P_ij.*(i.*j))); 
    corm = sum(sum(P_ij.*(i-u_xk).*(j-u_yk))); 
       out.autoc(k) = corp; 
    % Correlation  from paper 
    out.corrp(k) = (corp-u_xk*u_yk)/(s_x*s_y); 
    % Correlation from Matlab comand
    out.corrm(k) = corm/(s_x*s_y); 
end

