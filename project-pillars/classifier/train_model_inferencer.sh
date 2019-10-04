#!/bin/bash
set -e     #needed to ignore errors

d='/Users/mlafleur/Projects/SDGclassy/project-pillars'   #root path

c='cl_pillars_alt'                        #classifier training data subdirectory

w='extra-exclude-words_pillars.txt'			#stop words file

cd "${d}" && \
rm "${d}"/classifier/sources/"${c}"/.DS_Store || true   #Clean up on Mac. We ignore any errors here

#Import data
mallet import-dir --input "${d}"/classifier/sources/"${c}"/  --output "${d}"/classifier/output/"${c}".mallet --keep-sequence --remove-stopwords --extra-stopwords "${d}"/"${w}" --keep-sequence-bigrams --gram-sizes 1,2 

#Train topic model
mallet train-topics --input "${d}"/classifier/output/"${c}".mallet --output-state "${d}"/classifier/state/"${c}"-state.gz --output-doc-topics "${d}"/classifier/topics/"${c}"-topics.txt  --output-topic-keys "${d}"/classifier/topics/"${c}"-keys.txt --num-top-words 30 --optimize-interval 10 --num-topics 9 --output-model "${d}"/classifier/output/"${c}"-model 

#Use model to create inferencer
mallet train-topics --input-model "${d}"/classifier/output/"${c}"-model --inferencer-filename "${d}"/classifier/output/"${c}"-inferencer.mallet --num-iterations 0  

echo ""${c}" classifier and inferencer created in "${d}"/classifier/output/"
