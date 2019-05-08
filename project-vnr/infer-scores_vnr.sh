#!/bin/bash

d='~/Documents/GitHub/SDGclassy/' #specify root path
p='project-vnr'                  #project subdirectory
c='cl_base'                       #select classifier name
f='vnr_pdf'                      #select target files

cd "${d}" && \
rm "${d}"/"${p}"/"${f}"/.DS_Store ; \
mallet import-dir --input "${d}"/"${p}"/"${f}"  --output "${d}"/"${p}"/workshop/inferring-"${f}".mallet --keep-sequence --remove-stopwords --extra-stopwords "${d}"/workshop/extra-exclude-words.txt --keep-sequence-bigrams --gram-sizes 1,2  --use-pipe-from "${d}"/classifier/"${c}".mallet   && \
mallet infer-topics --input "${d}"/"${p}"/workshop/inferring-"${f}".mallet --inferencer "${d}"/classifier/"${c}"-inferencer.mallet --output-doc-topics "${d}"/"${p}"/output/scores-"${f}"-"${c}".txt   && \
echo "Command sequence finished successfully"
