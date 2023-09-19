  % Carrega pacotes do Octave
    pkg load io

  % Carrega os sinais salvos em uma pasta
    myFolder = ' '; %pasta com os arquivos .csv 
    addpath(myFolder)
    files = dir(myFolder);

    pathSave = ' '; %pasta onde os arquivos .mat serão salvos
  
  %Lendo os arquivos e transformando para .mat
    for i = 3:length(files)
      
    fullFileName = [files(i).folder, '/', files(i).name]
    [~, fileName, ~] = fileparts(fullFileName);
    
    dados = csvread(fullFileName);
    
    nameFile = [pathSave, fileName , '.mat']
    save(nameFile , 'dados');
    
    endfor



