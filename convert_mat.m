  % Carregar pacotes do Octave
    pkg load io

  % Carregar os sinais salvos em uma pasta
    myFolder = '/home/mavi/Documentos/Projects/Extração_atributos_método_1/versao_final/'; 
    addpath(myFolder)
    files = dir(myFolder);

    pathSave = '/home/mavi/Documentos/Projects/Extração_atributos_método_1/Sinal_mat/'; %pasta para salvar arff
  
  %Lendo os arquivos e transformando para .m
    for i = 3:length(files)
      
    fullFileName = [files(i).folder, '/', files(i).name]
    [~, fileName, ~] = fileparts(fullFileName);
    
    dados = csvread(fullFileName);
    
    nameFile = [pathSave, fileName , '.mat']
    save(nameFile , 'dados');
    
    endfor



