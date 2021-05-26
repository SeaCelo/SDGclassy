[string]$d = Get-Location     # root path
$c = 'sdg'                    # select classifier name
$f = 'target'                 # select target files
$w = 'extra-exclude-words.txt'

Set-Location $env:MALLET_HOME

bin/mallet import-dir `
  --input $d/$f `
  --output $d/$f/temp/inferring-$c.mallet `
  --keep-sequence `
  --remove-stopwords `
  --extra-stopwords $d/classifier/$w `
  --keep-sequence-bigrams `
  --use-pipe-from $d/classifier/$c.mallet

bin/mallet infer-topics `
  --input $d/$f/temp/inferring-$c.mallet `
  --inferencer $d/classifier/$c-inferencer.mallet `
  --output-doc-topics $d/$f/output/scores-$c.txt

Write-Output "Command sequence finished successfully. The results are available in /target/output/scores-$c.txt."
Write-Output "The mapping between the results and the SDGs is available in /classifier/topic-sdg_mapping.csv."

Pause