@echo on
doskey aliases=doskey /macros
doskey ll=dir/w
doskey gs=git status
doskey gb=git branch -a
doskey gd='git diff'
doskey gl=git log --decorate=short
doskey gbp='git remote prune origin'
doskey gitzap=git add . && git commit -m "!!!Commit all file and changes blindly!!!" && git push &&
doskey pecho=echo $1
echo change 4
echo [Done]
