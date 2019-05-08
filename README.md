# SDGclassy
SDG classification of texts using LDA topic model

Observations:
-Scripts are bash scripts  
-Training sources are one file per topic/SDG  
-Target sources are one file per publication to be classified  
-All data should be a mirror. Please keep originals in backup  
-project-xxxx is where target data should be placed and all analysis should be done. Edit script inside that subdirectory  
-In each script, edit the paths and the desired classifier  

Make sure to prepare scripts:  
chmod +x my_cool_script.sh

### Step 1: train and save a classifier  
(only needed if updating)  
In the classifier directory, edit the script to select the desired training data and classifier  
./train_model_inferencer.sh  

### Step 2: Apply a Saved Classifier to New Unlabeled Data (infer topics)  
In the project-xxxx directory, add target data and edit the script with desired classifier and paths  
./infer_scores_wess.sh

