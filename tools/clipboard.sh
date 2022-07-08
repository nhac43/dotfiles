# https://qiita.com/Kzno/items/6f2fa98256bdffb0fd43
function cb() {
    if [[ "$OSTYPE" == "linux-gnu"*  ]]; then
        cat $1 | xsel --clipboard --input
    elif [[ "$OSTYPE" == "darwin"*  ]]; then
        cat $1 | pbcopy
    else
        echo not supported
    fi
}
