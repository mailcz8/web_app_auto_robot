@echo on
doskey aliases=doskey /macros
doskey ll=dir/w
doskey gs=git status
doskey gb=git branch -a
doskey gd='git diff'
doskey gbp='git remote prune origin'
doskey gitzap=git add . && git commit -m %1 && git push
echo change 1
echo [Done]
