
URL="https://www.yamafuru.com/facility/camp/calendar/"
LOG_FILE="last_update_date.txt"
CHECK_INTERVAL_SEC=900

function get_yamafuru_update_date() {
    # ウェブページの内容を取得
    page_content=$(curl -s "$URL")

    # 日付文字列を抽出
    date_string=$(echo "$page_content" | grep '最終更新日時：' | awk -F'：|<' '{printf $2}')

    echo $date_string
}

function get_previous_update() {
    # 前回の日付をファイルから読み取る（初回実行時はファイルが存在しない）
    if [ -f $LOG_FILE ]; then
        previous_date=$(cat $LOG_FILE)
    fi

    echo $previous_date
}

function check_yamafuru() {
    last_update=$(get_yamafuru_update_date)
    previous_update=$(get_previous_update)

    current_date=$(date "+%Y-%m-%d %H:%M:%S")

    if [ "$last_update" != "$previous_update" ]; then
      echo "[$current_date] 日付が変更されました。前回: $previous_update, 現在: $last_update"
      echo "$last_update" > $LOG_FILE
      return 1
    fi

    return 0
}

while true; do
    check_yamafuru
    sleep $CHECK_INTERVAL_SEC
done
