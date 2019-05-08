#!/bin/bash

d='~/Desktop/themes/sdg_testing' #specify root path
c='cl_base'                      #select classifier name
f='wess-txt'                     #select target files

cd "${d}" && \
rm "${d}"/"${f}"/.DS_Store ; \
mallet import-dir --input "${d}"/"${f}"  --output "${d}"/workshop/sdg-inferring-"${f}".mallet --keep-sequence --remove-stopwords --extra-stopwords "${d}"/workshop/extra-exclude-words.txt --keep-sequence-bigrams --gram-sizes 1,2  --use-pipe-from "${d}"/workshop/"${c}".mallet   && \
mallet infer-topics --input "${d}"/workshop/sdg-inferring-"${f}".mallet --inferencer "${d}"/workshop/"${c}"-inferencer.mallet --output-doc-topics "${d}"/final-output/inferred-topics-"${f}"-"${c}".txt   && \
echo "Command sequence finished successfully"
