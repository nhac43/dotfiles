function gitb () {
    branch=$(git branch -a | fzf)
    git checkout ${branch#\*}
}
