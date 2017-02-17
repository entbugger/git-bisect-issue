#!/bin/bash

#cd "$(dirname "$0")"

#rm -fr .git/ file1.txt feature1.txt test_feature2.txt

git init

git branch rc
git branch rc

#1. MAKE SOME COMMITS IN THE MASTER branch
touch file1.txt
git add file1.txt
git commit -m "Add file1.txt"

sleep 1
echo "Line 1" >> file1.txt
git add file1.txt
git commit -m "Line 1, file1.txt"

sleep 1
echo "Line 2" >> file1.txt
git add file1.txt
git commit -m "Line 2, file1.txt"

git branch feature1
git branch feature2

#2. MAKE SOME COMMITS in the FEATURE1 branch
sleep 1
git checkout feature1
echo "Begin feature 1" >> feature1.txt; git add feature1.txt
git commit -a -m "Feature 1"

#2. MAKE 2 COMMITS in the FEATURE2 branch
sleep 1
git checkout feature2
echo "Line 3" >> file1.txt
git commit -a -m "Line 3, file1.txt"

echo "This an interesting test for all branches" >> test_feature2.txt; git add test_feature2.txt
echo "FEATURE2" >> file1.txt
git commit -a -m "Feature 2"
git tag -a v.good -m "Good version" #mark this as a good version


#3. Make some new commits in the MASTER branch
sleep 1
git checkout master
echo "Line 1" >> file2.txt
git add file2.txt
git commit -m "Line 1, file2.txt"


#4. Merge FEATURE2 in MASTER
sleep 1
git merge feature2 -m "Merge branch 'feature2'"

#5. Merge parts of FEATURE2 in FEATURE1, thus introducing a BUG
sleep 1
git checkout feature1
git merge feature2 --no-commit
#merge in only the new file test_feature2.txt
#and ignore changes made to file1.txt
git checkout HEAD -- file1.txt; 
git commit -m "Introduce bug"


#6. Merge FEATURE1 in MASTER
git checkout master
git merge feature1 -m "Merge branch 'feature1'"
git tag -a v.bad -m "Bad version" #mark this as a bad version, because it does not contain "FEATURE2" in file1.txt
