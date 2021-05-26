mallet-2.0.8/bin/mallet import-dir `
  --input ./target `
  --output ./target/temp/inferring-sdg.mallet `
  --keep-sequence `
  --remove-stopwords `
  --extra-stopwords ./classifier/extra-exclude-words.txt `
  --keep-sequence-bigrams `
  --use-pipe-from ./classifier/sdg.mallet

mallet-2.0.8/bin/mallet infer-topics `
  --input ./target/temp/inferring-sdg.mallet `
  --inferencer ./classifier/sdg-inferencer.mallet `
  --output-doc-topics ./target/output/scores-out.txt

Write-Output "Command sequence finished successfully. The results are available in /target/output/scores-out.txt."
Write-Output "The mapping between the results and the SDGs is available in /classifier/topic-sdg_mapping.csv."
