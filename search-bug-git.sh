cd git-bisect-issue
git bisect reset
git bisect start
git bisect bad v.bad
git bisect good v.good
git bisect run ../version-buggy.sh
