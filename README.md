GettingAndCleaningData
======================

Repo for Coursera Course Project Getting and Cleaning Data  John Hopkins 
----------------------

**files**
- README.md             this file
- Codebook.md           Description of Variables
- run_analysis.R        R Script which analyzes the 
                        Inputfiles
                        - X_test.txt
                        - y_test.txt
                        - subject_test.txt
                        - X_train.txt
                        - y_train.txt
                        - subject_train.txt
                        - activity_labels.txt
                        - features.txt
                        The script works if these files are
                        present in the current working directory.
                        The script produces a tidy dataset and
                        saves it as "tidy.txt".
- tidy.txt              The outputfile is tab-separated.
                        Produced by "run_analysis.R"