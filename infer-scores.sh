#!/bin/bash
set -e          #needed to ignore errors?

rm /target/input/.DS_Store || true   #we ignore any errors here

mallet import-dir --input /target/input  --output /target/workshop/inferring-temp.mallet --keep-sequence --remove-stopwords --extra-stopwords extra-exclude-words_new.txt --keep-sequence-bigrams --gram-sizes 1,2  --use-pipe-from /classifier/sdg.mallet   

mallet infer-topics --input /target/workshop/inferring-temp.mallet --inferencer /classifier/sdg-inferencer.mallet --output-doc-topics /target/output/scores-out.txt   

echo "Command sequence finished successfully"
