# パイプで受け取ったテキストをOSC52で送信
osc52_send() {
  # 標準入力をbase64エンコード
  local content
  content=$(base64 | tr -d '\n')
  # OSC52シーケンスを送信
  printf "\033]52;c;%s\a" "$content"
}

crp() {
  realpath $1 | osc52_send
}

