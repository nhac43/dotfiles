cat_reverse() {
    if which tac >/dev/null 2>&1; then
        tac $1
    else
        tail -r $1
    fi
}

expand_path(){
    # 標準入力から1行ずつ読み取る
    while IFS= read -r path; do
        # パスが空であればスキップ
        if [[ -z "$path" ]]; then
            continue
        fi

        # パスを '/' で分割して配列に格納
        IFS='/' read -ra ADDR <<< "$path"
        
        # 配列を逆順にして展開して表示
        # for ((i=${#ADDR[@]}; i>=1; i--)); do
        for ((i=${#ADDR[@]}; i>=2; i--)); do
            echo "${ADDR[@]:0:i}" | tr ' ' '/'
        done
        if [ ! -z "${ADDR[0]}" ]; then
            echo ${ADDR[0]}
        fi
    done
}

cd_fzf() {

    if [ ! -f "$CD_HISTORY_PATH" ]; then
        builtin cd
    fi

    if [ -z "$1" ] || [ "$1" = "-" ]; then
        # target_path=$(tail -r $CD_HISTORY_PATH | sed '1d' | fzf)
        # target_path=$(cat_reverse $CD_HISTORY_PATH | sed '1d' | fzf)
        # 最後の行はカレントディレクトリなため除く
        # 重複を除いた後にパスを展開、展開後の重複を再度除く
        target_path=$(cat_reverse $CD_HISTORY_PATH | sed '1d' | awk '!seen[$0]++' | expand_path | awk '!seen[$0]++' | fzf)
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
            # 既存のパスが含まれている場合は削除
            if grep -qFx "$target_path" "$CD_HISTORY_PATH"; then
                sed -i "\|^$target_path\$|d" "$CD_HISTORY_PATH"
            fi
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
