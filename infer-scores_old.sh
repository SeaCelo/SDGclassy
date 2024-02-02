#!/bin/bash
set -e          #needed to ignore errors?

rm /target/input/.DS_Store || true   #we ignore any errors here

./mallet-2.0.8/bin/mallet import-dir --input ./target/input  --output ./classifier/inferring-temp.mallet --keep-sequence --remove-stopwords --extra-stopwords ./classifier/extra-exclude-words.txt --keep-sequence-bigrams --gram-sizes 1,2  --use-pipe-from ./classifier/sdg.mallet   

./mallet-2.0.8/bin/mallet infer-topics --input ./classifier/inferring-temp.mallet --inferencer ./classifier/sdg-inferencer.mallet --output-doc-topics ./target/output/scores-out.txt   

echo "Command sequence finished successfully. The results are available in /target/output/scores-out.txt."
echo "The mapping between the results and the SDGs is available in /classifier/topic-sdg_mapping.csv."