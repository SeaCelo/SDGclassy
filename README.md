# SDGclassy
SDG classification of texts using LDA topic model


Scripts are bash scripts
Training sources are one file per topic/SDG
Target sources are one file per publication to be classified
All data in working directory should be a mirror. Authoritative data should be in input folder, and copied to working directory

Make sure to prepare scripts:

chmod +x my_cool_script.sh

## Step 1: train and save a classifier
(only needed if updating)

./train_model_inferencer.sh


## Step 2: Apply a Saved Classifier to New Unlabeled Data (infer topics)
#In the script, use a variable to specify the corpus folder name. Copy and add as needed

./infer_scores.sh




