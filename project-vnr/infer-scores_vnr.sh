#!/bin/bash
set -e          #needed to ignore errors?

d='~/Documents/GitHub/SDGclassy/' #specify root path
p='project-wess'                  #project subdirectory
c='cl_base'                       #select classifier name
f='wess_txt'                      #select target files

cd "${d}" 
rm "${d}"/"${p}"/"${f}"/.DS_Store || true   #we ignore any errors here

mallet import-dir --input "${d}"/"${p}"/"${f}"  --output "${d}"/"${p}"/workshop/inferring-"${f}".mallet --keep-sequence --remove-stopwords --extra-stopwords "${d}"/workshop/extra-exclude-words.txt --keep-sequence-bigrams --gram-sizes 1,2  --use-pipe-from "${d}"/classifier/"${c}".mallet   

mallet infer-topics --input "${d}"/"${p}"/workshop/inferring-"${f}".mallet --inferencer "${d}"/classifier/"${c}"-inferencer.mallet --output-doc-topics "${d}"/"${p}"/output/scores-"${f}"-"${c}".txt   

echo "Command sequence finished successfully"
