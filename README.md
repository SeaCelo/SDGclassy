# SDGclassy
SDG classification of texts using LDA topic model

This script is based on my work to classify UN publications according to each SDG. This tool provides a way to easily compute "SDG scores" for individual or a collection of texts. Each SDG is defined by a collection of training texts for each of the 17 SDGs taken from official UN publications.

To read the details of the methodology: "Art is long, life is short: An SDG Classification System for DESA Publications" (https://www.un.org/development/desa/publications/working-paper/wp159). 

A word of caution: this algorithm does not identify text that is outside the SDG scope. The scores represent an attempt to fit the entire text within the SDG vocabulary space. 

## Requires:
* Mallet 2.0.8 (http://mallet.cs.umass.edu)
* Text files to be classified (.txt)
* Covert your text files to .txt and clean them up as much as possible. The results will be better if you exclude non-relevant material (front matter, etc). 

### Tested on Mac OS X Big Sur, Windows and Linux:
* on Mac, Zsh shell is preferred, tough the code should run in older Bash shell (pre-Catalina). 
* On windows, bigrams command is broken. Need to apply this fix: https://github.com/mimno/Mallet/issues/151    

## Mac OS and UNIX Installation and use
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

### How to use:
* Add text files (txt only, no pdf, no directories) to: /SDGclassy/target/input/   
* Run the classification script

```
./infer-scores.sh
```
* Results will be placed in /SDGclassy/target/output/scores-out.txt

## Windows Installation and use 
* [Install WSL](https://docs.microsoft.com/en-us/windows/wsl/install-win10)
* Open a Powershell window inside the location you would like to install
* Type `wsl` and follow the [Mac and UNIX installation steps and usage instructions](#mac-os-and-unix-installation-and-use)

### Alternatively:
* From Powershell, cd into the location you would like to install
* clone the repository

```
git clone https://github.com/SeaCelo/SDGclassy.git SDGclassy
cd SDGclassy
```
* Install Mallet

```
wget http://mallet.cs.umass.edu/dist/mallet-2.0.8.zip -OutFile mallet-2.0.8.zip
unzip mallet-2.0.8.zip
rm mallet-2.0.8.zip
```

### How to use (with alternative method):
* Add text files (txt only, no pdf, no directories) to: /SDGclassy/target/input/   
* Run the classification script by right-clicking infer-scores.ps1 and selecting "Run with Powershell"
* Results will be placed in /SDGclassy/target/output/scores-out.txt

# Interpreting the Results
* topics are listed in order 0-18. Each topic maps to a specific SDG, with one topic as a filter to be ignored. The mapping between topics and SDGs is available in: /classifier/topic-sdg_mapping.csv
* Use the output in your favorite app (excel, etc) and analyze the results, using the topic-sdg mapping.
		


# Other notes
* The instructions will download Mallet in the SDGclassy directory, but you may want to install it in another location.
* In this event adjust the script accordingly or add Mallet to the $PATH. This is left to you and your google. 

* Note: using ngrams may cause Mallet to run out of memory. If you have this problem, try giving 8gb to Mallet, letting the OS manage any paging and vm. 
* To do this, edit the binary. In Terminal: 
   * `cd /path/to/your/install/mallet-2.0.8/bin` 
   * `nano mallet` 
   * Find the line and edit to read: `MEMORY=8g`
