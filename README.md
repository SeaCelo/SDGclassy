# SDGclassy
SDG classification of texts using LDA topic model

### Requires:
Mallet 2.0.8 (http://mallet.cs.umass.edu)


## Notes and Observations:  
### For Mac OS X:
* On Os X, scripts are written for bash shell. 
* (OS X Catalina will switch to zsh shell as default.)

### For Windows:
* To run on windows, scripts need to be edited. This is an open issue
* On windows, bigrams command is broken. Need to apply this fix: https://github.com/mimno/Mallet/issues/151    

## Usage:
* Pre-trained models are available in /SDGclassy/classifier/results
* The mapping of topics-to-sdg is for each classifier is available in /classifier/ 
* Training sources are one file per topic/SDG  
* Target sources are one file per publication to be classified  
* All data should be a mirror. Please keep originals in backup  

### To use a classifier to generate scores for your texts ("inferring"), follow these steps:
	1: create a new project directory ("/Users/myname/Projects/SDGclassy/project-yours")
	2: create a directory with only the target files ("/project-yours/target-txt/")
	3: Copy "/SDGclassy/scripts/infer-scores_template.sh" to project directory, and rename
	4: Open the .sh script and edit the variables (d,p,f,c). 
		Note: specify the paths and the classifier you want to use. A good option for a classifier is 'cl_base_new'
	5: Check all your paths and spellings. 
	6: On OS X Terminal:
		a: Navigate to your project directory: "cd /Users/myname/Projects/SDGclassy/project-yours"
		b: Get the script ready by making it executable: "chmod +x infer-scores_yourproject.sh"
		c: Run the script: "./infer-scores_yourproject.sh"
	7: The results will be in "/project-yours/output/" as a .txt
		Note: topics are listed in order 0-18. Each topic maps to a specific SDG, with one topic as a filter to be ignored. The mapping for a given classifier is available in: "/classifier/topic-sdg_mapping.xlsx". If you train a new model, the mapping will change and you will need to create your own mapping using the output of the training process. Hint: see which topic is the best match for each of the training files.
	8: Use the output in your favorite app (excel, etc) and analyze the results.
		
### To train and save a new classifier  
(This is only needed if you want to update or create a new classifier)  
1. In "/classifier/sources/", create or choose a directory with your source data. One file per SDG.
1. In the "/classifier/" directory, edit the script "train_model_inferencer.sh" to point to your root path and to the training data directory  
	* Note: edit variables "d" and "c"
1. On OS X Terminal, run the script: "./train_model_inferencer.sh"  
	* It is possible that if you edit the script in BBEdit or another non-sandboxed app, that it will be placed in a quarantine. If you get an error in running the script, try: " xattr -d com.apple.quarantine /path/to/your/script.sh "
	* See discussion here: https://talk.automators.fm/t/bash-shell-script-not-able-to-run/4908 
1. The model will be placed in "/classifier/results/"
