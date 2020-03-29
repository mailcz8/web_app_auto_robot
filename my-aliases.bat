@echo on
doskey aliases=doskey /macros
doskey ll=dir/w
doskey gs=git status
doskey gb=git branch -a
doskey gd='git diff'
doskey gbp='git remote prune origin'
doskey gitzap=git add . && git commit -m "update" && git push
echo [Done]
