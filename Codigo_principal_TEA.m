% ------------------------------------------------------------------------------
% Autores: Juliana Gomes, Jessiane Pereira, Wellington dos Santos
% Universidade Federal de Pernambuco, Universidade de Pernambuco
% Contato: jcg@ecomp.poli.br, jmsp@ecomp.poli.br, wellington.pinheirodossantos@gmail.com
% ------------------------------------------------------------------------------

% Funcao geral para leitura de sinais de EEG, extra��o de atributos e cria��o de um
% arquivo .ARFF

% Variaveis:
% Y - sinal
% Para Y(i,j), i deve ser o sinal no tempo e j os canais do EEG
% Xf - sinal ap�s windowmento
% Fs - frequencia de amostragem em Hz
% janela - tamanho da janela em s
% superposicao - Superposi��o da janela em s
% n_canais - numero de canais do sinal 
% n_sinal - numero de sinal que precisam ser carregados; 
% sinal - indica a numera��o do sinal que ser� carregado;
% Informa classe  - classe do sinal que encontra-se em carregamento;


% Carregar pacotes do Octave
    pkg load image 
    pkg load signal
    
% Carregar os sinais salvos em uma pasta
    myFolder = ' '; %pasta com sinais em .mat 
    addpath(myFolder)
    files = dir(myFolder); %files contem os nomes dos arquivos que estao na pasta
    pathSave = ' '; %pasta para salvar o arff

% Parametros iniciais 
    Fs = 512;           % Frequencia de amostragem em Hz
    janela=2;           % Tamanho da janela em segundos
    superposicao=0.5;   % Superposicao da janela em segundos
    n_canais = 64;      % Numero de canais (eletrodos)
    classes = [0];
    %classes = [0 0 1 1]; % A ordem das classes deve corresponder � ordem dos arquivos salvos em files
    atributos_total =[];  % Criacao de vetores
    vetor_classes =[];

  for i = 3:length(files)   
    
    [Y] = load(files(i).name); % Carrega o sinal e salva na variavel X
     Y = [struct2cell(Y){:}];

    % Janelamento do sinal e Extracao de atributos
      atributos = [];
      [atributos] = extracao_atributos(Y, Fs, janela, superposicao, n_canais);
      [l,c] = size(atributos);
  
      aux = i-2;
      classe = classes(aux);   % Classe do sinal carregado
      temp_classe = [];
      
      for a= 1:(l)
        temp_classe(a,1)= classe;  %Cria um vetor com a classe referente ao sinal carregado
      endfor
  
      vetor_classes = [vetor_classes; temp_classe]; 
      atributos_total = [atributos_total; atributos];

  endfor

  % Gerar arquivo ARFF e CSV para posterior classificacao
      matriz = [atributos_total vetor_classes];
      [ARFF] = geraARFF(pathSave,'P',matriz);
