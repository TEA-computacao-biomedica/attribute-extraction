function [ARFF] = geraARFF(path, nome, matriz)
%%Gerar arquivo .arff
classes = {};

target = matriz(:,end);
nel = size(matriz(:,1:end-1),2);
nomeArq = strcat (path,nome,'.arff');
FID = fopen (nomeArq, 'w');
bit = fprintf (FID, '@relation %s\n', nome);
for i = 1:nel
    bit = fprintf (FID, strcat('@attribute x',num2str(i),' numeric \n'));
end
vetor = unique(target);
attributeClass = '@attribute class {';
for i = 1:size(vetor,1)   
    if i == size(vetor,1)
        attributeClass = strcat(attributeClass,'C',num2str(vetor(i)),'}\n');
    else
        attributeClass = strcat(attributeClass,'C',num2str(vetor(i)),',');
    end
end

bit = fprintf (FID, attributeClass);
bit = fprintf (FID, '@data \n');

remove = [];
c = 1;
for k = 1:size(matriz(:,end-1),1)
    classes{k,1} = strcat('C',num2str(target(k)));    
end

matriz = matriz(:,1:end-1);
for j = 1:size(matriz,1)
    for i = 1:size(matriz,2)
        bit = fprintf (FID, '%.5f,', matriz(j,i));
    end
    bit = fprintf (FID, '%s\n', classes{j,:});
end

ARFF = matriz;
fclose(FID);
fclose all;