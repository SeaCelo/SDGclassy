mallet-2.0.8/bin/mallet import-dir `
  --input ./target `
  --output ./target/temp/inferring-temp.mallet `
  --keep-sequence `
  --remove-stopwords `
  --extra-stopwords ./classifier/extra-exclude-words.txt `
  --keep-sequence-bigrams `
  --use-pipe-from ./classifier/sdgclassy.mallet

mallet-2.0.8/bin/mallet infer-topics `
  --input ./target/temp/inferring-temp.mallet `
  --inferencer ./classifier/sdgclassy-inferencer.mallet `
  --output-doc-topics ./target/output/SDG-scores-out.txt

Write-Output "Command sequence finished successfully. The results are available in /target/output/SDG-scores-out.txt."
Write-Output "The mapping between the results and the SDGs is available in /classifier/topic-sdg_mapping.csv."
