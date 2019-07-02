#!/bin/bash
set -e          #needed to ignore errors?

d='/Users/mlafleur/Projects/SDGclassy' 	#specify root path
p='project-vnr'                  		#project subdirectory
c='cl_base_new'                       	#select classifier name
f='vnr_txt'                      		#select target files
w='extra-exclude-words_new.txt'			#stop words file

cd "${d}" 
rm "${d}"/"${p}"/"${f}"/.DS_Store || true   #we ignore any errors here

mallet import-dir --input "${d}"/"${p}"/"${f}"  --output "${d}"/"${p}"/workshop/inferring-"${f}".mallet --keep-sequence --remove-stopwords --extra-stopwords "${d}"/workshop/"${w}" --keep-sequence-bigrams --gram-sizes 1,2  --use-pipe-from "${d}"/classifier/results/"${c}".mallet   

mallet infer-topics --input "${d}"/"${p}"/workshop/inferring-"${f}".mallet --inferencer "${d}"/classifier/results/"${c}"-inferencer.mallet --output-doc-topics "${d}"/"${p}"/output/scores-"${f}"-"${c}".txt   

echo "Command sequence finished successfully"
