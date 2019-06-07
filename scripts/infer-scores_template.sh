#!/bin/bash
set -e          #needed to ignore errors

d='/Users/mlafleur/Projects/SDGclassy/' 	#specify root path
p='project-vnr'                  			#project subdirectory
f='vnr_txt'                      			#select target files
c='cl_base_plus_alt'                       	#select classifier name

cd "${d}" 
rm "${d}"/"${p}"/"${f}"/.DS_Store || true   #Clean up. We ignore any errors here

#Import target data
mallet import-dir --input "${d}"/"${p}"/"${f}"  --output "${d}"/"${p}"/workshop/inferring-"${f}".mallet --keep-sequence --remove-stopwords --extra-stopwords "${d}"/workshop/extra-exclude-words.txt --keep-sequence-bigrams --gram-sizes 1,2  --use-pipe-from "${d}"/classifier/results/"${c}".mallet   

#Apply topic model and get SDG scores
mallet infer-topics --input "${d}"/"${p}"/workshop/inferring-"${f}".mallet --inferencer "${d}"/classifier/results/"${c}"-inferencer.mallet --output-doc-topics "${d}"/"${p}"/output/scores-"${f}"-"${c}".txt   

echo "Command sequence finished successfully"
