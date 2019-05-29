#!/bin/bash

set -e     #needed to ignore errors below

s='sdg14'                        					#testing data directory
d='/Users/mlafleur/Projects/SDGclassy/classifier/test_data' 		#specify root path
cd "${d}" 

for c in cl_base_new cl_base ;  do 

rm "${d}"/"${s}"/.DS_Store || true   				#we ignore any errors here

mallet import-dir --input "${d}"/"${s}"  --output "${d}"/workshop/test_"${s}"-"${c}".mallet --keep-sequence --remove-stopwords --extra-stopwords "${d}"/workshop/extra-exclude-words.txt --keep-sequence-bigrams --gram-sizes 1,2  --use-pipe-from ~/Projects/SDGclassy/classifier/results/"${c}".mallet   

mallet infer-topics --input "${d}"/workshop/test_"${s}"-"${c}".mallet --inferencer ~/Projects/SDGclassy/classifier/results/"${c}"-inferencer.mallet --output-doc-topics "${d}"/output/scores_"${s}"-"${c}".txt   

continue
echo ""${c}" command sequence finished successfully"

done

