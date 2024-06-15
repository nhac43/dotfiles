export CD_HISTORY_LIMIT=100
cd() {
    if [ -z "$1" ] || [ "$1" = "-" ]; then
        target_path=$(tail -r $HOME/.cd_history | sed '1d' | fzf)
        if [ ! -e "$target_path" ]; then
            return
        fi
    else
        # 引数として渡されたパスをフルパスに変換
        target_path=$(realpath "$1" 2>/dev/null)
    fi

    if [ -e "$target_path" ]; then
        # .cd_history が存在し、かつ最後の行が target_path でない場合に追記
        if [ ! -f "$HOME/.cd_history" ]; then
            echo "$target_path" >> "$HOME/.cd_history"
        elif [ "$(tail -n 1 "$HOME/.cd_history")" != "$target_path" ]; then
            echo "$target_path" >> "$HOME/.cd_history"
        fi
        if [ -n "$CD_HISTORY_LIMIT" ]; then
            current_lines=$(wc -l < "$HOME/.cd_history")
            while [ "$current_lines" -gt "$CD_HISTORY_LIMIT" ]; do
                sed -i '1d' "$HOME/.cd_history"
                current_lines=$(wc -l < "$HOME/.cd_history")
            done
        fi
        builtin cd "$target_path"
    else
        builtin cd $1
    fi
}
