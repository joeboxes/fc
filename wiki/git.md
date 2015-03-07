# git.md

### installing
#### debian
```
sudo apt-get install git
```
#### MAC:
```
http://git-scm.com/book/en/v2/Getting-Started-Installing-Git
```

### git repo from existing public
```
# find clone URL from github
git clone git@github.com:accountNameHere/repoNameHere.git
cd repoNameHere
```


### add ssh keys
```
ssh-keygen
...
```

### git repo from scratch
```
# change into project directory
cd ~/...
# start git
git init
# add desired remote (github)
git remote add origin git@github.com:accountNameHere/repoNameHere.git
# add desired files
git add .
# save
git commit -m"added files"
# push
git push origin master
```



### pulling


### changing: adding/removing


### pushing


### branching



### merging






