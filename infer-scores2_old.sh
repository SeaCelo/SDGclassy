#!/bin/bash

function usage {
        echo '   -i INPUT   Folder with input texts'
        echo '   -o OUTPUT  Location for the output scores'
        exit 1
}

# if no input argument found, exit the script with usage
if [[ ${#} -eq 0 ]]; then
   usage
fi

# Define list of arguments expected in the input
optstring=":i:o:"

while getopts ${optstring} arg; do
  case ${arg} in
    i)
      INPUT="${OPTARG}"
      ;;
    o)
      OUTPUT="${OPTARG}"
      ;;
    ?)
      echo "Invalid option: -${OPTARG}."
      echo
      usage
      ;;
  esac
done


set -e          #needed to ignore errors?

rm "${INPUT}"/.DS_Store || true   #we ignore any errors here

./mallet-2.0.8/bin/mallet import-dir --input "${INPUT}"  --output ./classifier/inferring-temp.mallet --keep-sequence --remove-stopwords --extra-stopwords ./classifier/extra-exclude-words.txt --keep-sequence-bigrams --gram-sizes 1,2  --use-pipe-from ./classifier/sdg.mallet   


./mallet-2.0.8/bin/mallet infer-topics --input ./classifier/inferring-temp.mallet --inferencer ./classifier/sdg-inferencer.mallet --output-doc-topics "${OUTPUT}"/SDG-scores.txt   

echo "Command sequence finished successfully. The results are available in the file SDG-scores.txt."
echo "The mapping between the results and the SDGs is available in /classifier/topic-sdg_mapping.csv."

exit 0