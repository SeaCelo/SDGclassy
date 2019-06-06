import pandas as pd
import glob, os
import re
import nltk
from nltk import word_tokenize
from nltk import pos_tag
from nltk.corpus import PlaintextCorpusReader
import gensim
from gensim.utils import simple_preprocess
from nltk.stem import WordNetLemmatizer, SnowballStemmer
from nltk.stem.porter import *
import numpy as np
np.random.seed(2018)
stemmer = SnowballStemmer('english')
stopwords = nltk.corpus.stopwords.words('english')
files = ".*"
extra = PlaintextCorpusReader(r"C:\Users\desalegn.biru\mallet\Extra-Stop", files)
stopwords.extend(extra.words())

path =r'C:\Program Files (x86)\Microsoft Visual Studio\Shared\Python36_64\Scripts\cl_base_new'
all_files = glob.glob(os.path.join(path, "*.txt"))
documents = []
for file in all_files:
    f = open(file,  encoding="utf8")
    df= f.read()
    df.replace('\t', '').replace('\n', '').replace('\r', '')
    f.close()
    documents.append(df)
df = pd.DataFrame(data=documents)


def nouns_adj(text):
    is_noun_adj = lambda pos: pos[:2] == 'NN' or pos[:2] == 'JJ'
    tokenized = word_tokenize(text)
    nouns_adj = [word for (word, pos) in nltk.pos_tag(tokenized) if is_noun_adj(pos)] 
    return ' '.join(nouns_adj)
def lemmatize_stemming(text):
    return WordNetLemmatizer().lemmatize(nouns_adj(text), pos='v')
    #return stemmer.stem(WordNetLemmatizer().lemmatize(nouns_adj(text), pos='v'))
def preprocess(text):
    result = []
    for token in gensim.utils.simple_preprocess(text):
        if token not in stopwords and len(token) > 3:
            result.append(lemmatize_stemming(token))
    return result


processed_docs = df[0].map(preprocess)

counter = 1
goals = {1:1,  2:10,  3: 11, 4:12, 5:13, 6:14, 7:15, 8:16, 9:17, 10:2, 11:3, 12:4, 13:5, 14:6, 15:7, 16:8, 17:9}

for x in processed_docs.values:
    np.savetxt(r"C:\Users\desalegn.biru\mallet\Extra\Goal-new" + str(goals[counter]) + ".txt", x, fmt='%s')
    counter = counter + 1

