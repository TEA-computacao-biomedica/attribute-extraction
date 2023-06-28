% Y - sinal
% Para Y(i,j), i deve ser o sinal no tempo e j os canais do EEG
% Fs - frequencia de amostragem
% janela - tamanho da janela em s
% superposicao - Superposição da janela
% n_canais - numeros de canais do sinal 

function [atributos_janela] = extracao_atributos (Y, Fs, janela, superposicao, n_canais)

    atributos_janela = [];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% "JANELAMENTO" %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

    jan_tot =round(janela/(1/Fs));                % número de pontos de uma janela
    superpos = round(superposicao/(1/Fs));        % número de pontos da superposição
    step = jan_tot-superpos;                      % step
    num_janelas = floor(((size(Y,1)-jan_tot)/step)+1);  % número total de janelas
    
    % Varrer todo sinal e janelar    
    for h = 0:(num_janelas-1)
      vec_atributos = [];
      for k = 1:n_canais
        Xf = Y(step*h+1:step*h+jan_tot,k); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% "ATRIBUTOS" %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
       % Calcula e extrai atributos em cada janela por canal
       % Monta matriz de atributos
        [atr_janela] = atributos(Xf,num_janelas,n_canais);     
        vec_atributos = [vec_atributos atr_janela]; 
       end
       linha = h+1;
       atributos_janela(linha,:) = vec_atributos;
    end
 
end
