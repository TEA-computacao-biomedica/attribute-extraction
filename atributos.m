function [atr_janela] = atributos(Xf,num_janelas,n_canais)

% Xf - sinal após janelamento
% num_janelas - número total de janela
% n_canais - numeros de canais do sinal (atenção retirar nº de eletrodos de referência)
% atr_janela - atributos de cada canal por janela

##     AAC   %Average Amplitude Change
##     DASDV %Difference Absolute Deviation
##     IAV   %Intagrated Absolute Value
##     LOGD  %Logarithm Detector
##     MAV   %Mean Absolute Value
##     MLOGK %Mean Logarithm Kernel
##     RMS   %Root Mean Square
##     KURT  %Kurtosis
##     SSC   %Slope Sign Changes
##     SSI   %Simple Square Integral
##     SSI   %Simple Square Integral
##     VAR   %Variance
##     WFL   %Waveform Length
##     ZCS   %Zero Crossings
##     TM3   %Third Moment
##     TM4   %Fourth Moment
##     TM5   %Fifth Moment
##     STD   %Standard Deviation
##     MVAL  %Mean Value
##     MAX   %Maximum Amplitude
##     PSR   %Power Spectrum Ratio
##     PKF   %Peak Frequency
##     MNP   %Mean Power
##     MDF   %Median Frequency
##     MNF   %Mean Frequency   
##     TTP   %Total Power
##     VCF   %Variance of Central Frequency
##     SM1   %1st Spectral Moments
##     SM2   %2s     "        "
##     SM3   %3rd    "        "
##     SLOPECHANGES= [];
##     ZEROCROSSINGS = [];
##     SKEWNESS= [];
##     HJORTHPARAM_activity=[];
##     HJORTHPARAM_mobility=[];
##     HJORTHPARAM_complexity=[];
##     WAVEFORMLENGTH = [];

  [P, F] = periodogram(Xf);
  [lin,col] = size(P);
  
            %%%% Shannon Entropy %%%%%
            Xf2 = double(Xf(:));
            Xf2 = Xf2(Xf2~=0).^2;
            ENTROPY = -sum(Xf2.*log(eps+Xf2));
            %%%%%%%%%%%%%%

            ZEROCROSSINGS = length(find(diff(sign(Xf))));
            SLOPECHANGES = length(find(diff(sign(diff(Xf)))));
            SKEWNESS = skewness(Xf);
            HJORTHPARAM_activity = var(Xf);
            HJORTHPARAM_mobility = sqrt((var(diff(Xf)))/var(Xf));
            HJORTHPARAM_complexity = (sqrt(var(diff(diff(Xf))))/(var(diff(Xf))))/sqrt((var(diff(Xf)))/var(Xf));
            AAC = (1/lin)*(sum(abs(diff((Xf)))));
            DASDV = sqrt((1/(lin-1))*(sum(diff((Xf)).^2)));
            IAV = sum((Xf));
            LOGD = exp((1/lin)*(sum(log10(abs((Xf))))));
            MAV = (1/lin)*(sum(abs((Xf))));
            MLOGK = (1/lin)*(abs(sum((Xf))));
            RMS = sqrt((1/lin)*(sum((Xf).^2)));
            KURT = kurtosis((Xf));
            SSC = length(find(diff(sign(diff((Xf))))));
            SSI = sum((Xf).^2);
            VAR = var((Xf));
            ZCS = length(find(diff(sign((Xf)))));
            TM3 = abs((1/lin)*(sum((Xf).^3)));
            TM4 = abs((1/lin)*(sum((Xf).^4)));
            TM5 = abs((1/lin)*(sum((Xf).^5)));
            STD = std((Xf));
            MVAL = (1/lin)*(sum((Xf)));
            MAX = max((Xf));
            PSR = ((max(P))/(sum(P)));
            MNF = sum(F.*P)/sum(P);
            MNP = sum(P/length(F));
            PKF = max(P);
            TTP = sum(P);
            SM1 = sum(F.*P);
            SM2 = sum((F.^2).*P);
            SM3 = sum((F.^3).*P);
            VCF = (((SM2)/(TTP)) - ((SM1)/(TTP)).^2);
            MDF = (1/2)*(sum(P));
            
            atr_janela = [ZEROCROSSINGS SLOPECHANGES SKEWNESS HJORTHPARAM_activity HJORTHPARAM_mobility HJORTHPARAM_complexity AAC DASDV IAV LOGD MAV MLOGK RMS KURT SSC SSI VAR ZCS TM3 TM4 TM5 STD MVAL MAX PSR MNF MNP PKF TTP SM1 SM2 SM3 VCF MDF];
