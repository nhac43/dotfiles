if [[ "$(uname)" == 'Darwin' ]]; then
    IS_OSX=1
else
    IS_OSX=0
fi

cat_reverse() {
    # if which tac >/dev/null 2>&1; then
    if [[ ! $IS_OSX -eq 1 ]]; then
        tac $1
    else
        tail -r $1
    fi
}

expand_path(){
    # 標準入力から1行ずつ読み取る
    while IFS= read -r line; do
        # パスが空であればスキップ
        if [[ -z "$line" ]]; then
            continue
        fi

        # パスを '/' で分割して配列に格納
        if [[ ! $IS_OSX -eq 1 ]]; then
            IFS='/' read -ra ADDR <<< "$line"
        else
            IFS='/' read -rA ADDR <<< "$line"
        fi
        
        # 配列を逆順にして展開して表示
        for ((i=${#ADDR[@]}; i>=2; i--)); do
            echo "${ADDR[@]:0:$i}" | tr ' ' '/'
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
        # 最後の行はカレントディレクトリなため除く
        # 重複を除いた後にパスを展開、展開後の重複を再度除く
        # ===============================================
        # 1 直前のパス (cd -相当)
        # 2...i 現在のパスの展開パス(現在のパスを除く)
        # i+1...j 直前のパスの展開パス(直前のパスを除く)
        # j+1... その他の履歴
        # ===============================================
        # target_path=$(cat_reverse $CD_HISTORY_PATH | awk '!seen[$0]++' | expand_path | sed '1d' | { tail -n 2 $CD_HISTORY_PATH | head -n 1; cat -; } | awk '!seen[$0]++' | fzf)
        target_path=$(cat_reverse $CD_HISTORY_PATH | awk '!seen[$0]++' | sed '1d' | fzf)
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

            last_dir=$(tail -n 1 "$CD_HISTORY_PATH")
            if [[ ! $IS_OSX -eq 1 ]]; then
                sed -i -e '$d' "$CD_HISTORY_PATH"
            else
                sed -i '' -e '$d' "$CD_HISTORY_PATH"
            fi

            # パスを '/' で分割して配列に格納
            if [[ ! $IS_OSX -eq 1 ]]; then
                IFS='/' read -ra ADDR <<< "$target_path"
            else
                IFS='/' read -rA ADDR <<< "$target_path"
            fi

            # 配列を逆順にして展開して表示
            # if [ ! -z "${ADDR[0]}" ]; then
            #     new_line=${ADDR[0]}
            #     # 既存のパスが含まれている場合は削除
            #     if grep -qFx "$new_line" "$CD_HISTORY_PATH"; then
            #         if [[ ! $IS_OSX -eq 1 ]]; then
            #             sed -i "\|^$new_line\$|d" "$CD_HISTORY_PATH"
            #         else
            #             # BSD sed
            #             sed -i "" "\|^$new_line\$|d" "$CD_HISTORY_PATH"
            #         fi
            #     fi
            #     echo "$new_line" >> "$CD_HISTORY_PATH"
            # fi
            for ((i=2; i<${#ADDR[@]}; i++)); do
                new_line=$(echo "${ADDR[@]:0:$i}" | tr ' ' '/')
                # 既存のパスが含まれている場合は削除
                if grep -qFx "$new_line" "$CD_HISTORY_PATH"; then
                    if [[ ! $IS_OSX -eq 1 ]]; then
                        sed -i "\|^$new_line\$|d" "$CD_HISTORY_PATH"
                    else
                        # BSD sed
                        sed -i "" "\|^$new_line\$|d" "$CD_HISTORY_PATH"
                    fi
                fi
                echo "$new_line" >> "$CD_HISTORY_PATH"
            done
            echo "$last_dir" >> "$CD_HISTORY_PATH"
            new_line=$(echo "${ADDR[@]:-1}" | tr ' ' '/')
            # 既存のパスが含まれている場合は削除
            if grep -qFx "$new_line" "$CD_HISTORY_PATH"; then
                if [[ ! $IS_OSX -eq 1 ]]; then
                    sed -i "\|^$new_line\$|d" "$CD_HISTORY_PATH"
                else
                    # BSD sed
                    sed -i "" "\|^$new_line\$|d" "$CD_HISTORY_PATH"
                fi
            fi
            echo "$new_line" >> "$CD_HISTORY_PATH"

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
