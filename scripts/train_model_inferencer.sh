#!/bin/bash

d='~/Desktop/themes/sdg_testing' 
c='cl_base'  

cd "${d}" && \
rm "${d}"/classifier/"${c}"/.DS_Store ; \

mallet import-dir --input "${d}"/classifier/"${c}"/  --output "${d}"/workshop/"${c}".mallet --keep-sequence --remove-stopwords --extra-stopwords "${d}"/workshop/extra-exclude-words_alt.txt --keep-sequence-bigrams --gram-sizes 1,2 
mallet train-topics --input "${d}"/workshop/"${c}".mallet --output-state "${d}"/workshop/"${c}"-state.gz --output-doc-topics "${d}"/final-output/"${c}"-topics-sdg.txt  --output-topic-keys "${d}"/final-output/"${c}"-keys-sdg.txt   --optimize-interval 10 --num-topics 18 --output-model "${d}"/workshop/"${c}"-model 
mallet train-topics --input-model "${d}"/workshop/"${c}"-model --inferencer-filename "${d}"/workshop/"${c}"-inferencer.mallet --num-iterations 0  
echo ""${c}" classifier and inferencer created in "${d}"/workshop"
