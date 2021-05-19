# SDGclassy
SDG classification of texts using LDA topic model

This script is based on my work to classify UN publications according to each SDG. This tool provides a way to easily compute "SDG scores" for individual or a collection of texts. Each SDG is defined by a collection of training texts for each of the 17 SDGs taken from official UN publications.

To read the details of the methodology: "Art is long, life is short: An SDG Classification System for DESA Publications" (https://www.un.org/development/desa/publications/working-paper/wp159). 

A word of caution: this algorithm does not identify text that is outside the SDG scope. The scores represent an attempt to fit the entire text within the SDG vocabulary space. 

## Requires:
Mallet 2.0.8 (http://mallet.cs.umass.edu)
Text files to be classified (.txt)

### Tested on Mac OS X Big Sur:
* Zsh shell is preferred, tough the code should run in older Bash shell (pre-Catalina). 

### There is no support for Windows, but the script should work. However:
* To run on windows, scripts need to be edited. This is an open issue
* On windows, bigrams command is broken. Need to apply this fix: https://github.com/mimno/Mallet/issues/151    

## Installation
* From the Terminal shell, cd into the location you would like to install
* clone the repository

```
git clone https://github.com/SeaCelo/SDGclassy.git SDGclassy
cd SDGclassy
chmod +x infer-scores.sh
```
* Install Mallet
```
wget http://mallet.cs.umass.edu/dist/mallet-2.0.8.zip
unzip mallet-2.0.8.zip
rm mallet-2.0.8.zip
```

## How to use:
* Add text files to /SDGclassy/target/input/   (no directories)
* Run the classification script

```
./infer-scores.sh
```
* Results will be placed in /SDGclassy/target/output/scores-out.txt

## Interpreting the Results
* topics are listed in order 0-18. Each topic maps to a specific SDG, with one topic as a filter to be ignored. The mapping between topics and SDGs is available in: /classifier/topic-sdg_mapping.csv
* Use the output in your favorite app (excel, etc) and analyze the results, using the topic-sdg mapping.
		


## Other notes
* It is useful to add Mallet to the $PATH. In Terminal: 
   * `echo $PATH`    		this will print the current path, to check. 
   * `nano ~/.zshenv`		to edit 
   * (include this line somewhere:) 
   * `export PATH=$PATH:/path/to/your/install/mallet-2.0.8/bin` 

   * write out and exit 
   * If you don't have this, just navigate to the /mallet-2.0.8/bin and run the command from there. 

* Note: using ngrams causes Mallet to run out of memory. Giving 8gb to Mallet seems to work, and lets the OS manage any paging and vm. To do this, edit the binary. In Terminal: 
   * `cd /path/to/your/install/mallet-2.0.8/bin` 
   * `nano mallet` 
   * Find the line and edit to read: `MEMORY=8g`
