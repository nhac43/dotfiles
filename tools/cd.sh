export CD_HISTORY_LIMIT=100
export CD_HISTORY_PATH=$HOME/.cd_history

cat_reverse() {
    if which tac >/dev/null 2>&1; then
        tac $1
    else
        tail -r $1
    fi
}

cd() {
    if [ -z "$1" ] || [ "$1" = "-" ]; then
        # target_path=$(tail -r $CD_HISTORY_PATH | sed '1d' | fzf)
        target_path=$(cat_reverse $CD_HISTORY_PATH | sed '1d' | fzf)
        if [ ! -e "$target_path" ]; then
            return
        fi
    else
        # 引数として渡されたパスをフルパスに変換
        target_path=$(realpath "$1" 2>/dev/null)
    fi

    if [ -e "$target_path" ]; then
        # .cd_history が存在し、かつ最後の行が target_path でない場合に追記
        if [ ! -f "$CD_HISTORY_PATH" ]; then
            echo "$target_path" >> "$CD_HISTORY_PATH"
        elif [ "$(tail -n 1 "$CD_HISTORY_PATH")" != "$target_path" ]; then
            echo "$target_path" >> "$CD_HISTORY_PATH"
        fi
        if [ -n "$CD_HISTORY_LIMIT" ]; then
            current_lines=$(wc -l < "$CD_HISTORY_PATH")
            while [ "$current_lines" -gt "$CD_HISTORY_LIMIT" ]; do
                sed -i '1d' "$CD_HISTORY_PATH"
                current_lines=$(wc -l < "$CD_HISTORY_PATH")
            done
        fi
        builtin cd "$target_path"
    else
        builtin cd $1
    fi
}
