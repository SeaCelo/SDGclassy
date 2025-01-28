#!/bin/bash

# Function to display usage instructions
function usage {
    echo '   -i INPUT   Folder with input texts'
    echo '   -o OUTPUT  Location for the output scores'
    exit 1
}

# Exit the script and display usage if no input arguments are provided
if [[ ${#} -eq 0 ]]; then
   usage
fi

# Define expected input arguments
optstring=":i:o:"

# Parse input arguments
while getopts ${optstring} arg; do
  case ${arg} in
    i)
      INPUT="${OPTARG}" # Input folder containing texts to classify
      ;;
    o)
      OUTPUT="${OPTARG}" # Output location for the classification scores
      ;;
    ?)
      echo "Invalid option: -${OPTARG}."
      echo
      usage
      ;;
  esac
done

# Enable script to stop execution on errors
set -e

# Remove unnecessary system files from the input directory (if present)
rm "${INPUT}"/.DS_Store || true # Ignore errors if the file does not exist

# Step 1: Import input texts into a MALLET-compatible format
./mallet-2.0.8/bin/mallet import-dir \
  --input "${INPUT}" \
  --output ./classifier/inferring-temp.mallet \
  --keep-sequence \
  --remove-stopwords \
  --extra-stopwords ./classifier/extra-exclude-words.txt \
  --keep-sequence-bigrams \
  --gram-sizes 1,2 \
  --use-pipe-from ./classifier/sdgclassy.mallet   

# Step 2: Infer topic probabilities for each document using the pre-trained classifier
./mallet-2.0.8/bin/mallet infer-topics \
  --input ./classifier/inferring-temp.mallet \
  --inferencer ./classifier/sdgclassy-inferencer.mallet \
  --output-doc-topics "${OUTPUT}"/SDG-scores-out.txt

# Step 3: Replace the header of the output file
# The new header maps the topics generated in the inference step to specific SDGs,
# based on the original classification model used to train the inferencer.
echo -e "#doc\tname\tSDG 13\tSDG 1\tSDG 10\tSDG 2\tSDG 3\tSDG filter-delete\tSDG 5\tSDG 17\tSDG 6\tSDG 16\tSDG 12\tSDG 15\tSDG 11\tSDG 4\tSDG 7\tSDG 8\tSDG 9\tSDG 14" > temp_header.txt

# Append the content of the original output file (excluding its header) to the new header
tail -n +2 "${OUTPUT}"/SDG-scores-out.txt >> temp_header.txt

# Replace the original output file with the updated version
mv temp_header.txt "${OUTPUT}"/SDG-scores-out.txt

# Display a success message
echo "Command sequence finished successfully using the sdgclassy.mallet model."
echo "The results are available in the file SDG-scores-out.txt."
echo "The mapping between the results and the SDGs is available in /classifier/topic-sdg_mapping.csv."

# Exit the script
exit 0
