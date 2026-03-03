#!/bin/bash
# 接続を維持してストリームを受け取る
while true; do
	# --unbuffered を付けることで、データが届くたびに即座に出力します
	# jq 内で null を "default" に変換します
	echo '{"RequestCurrentLayerName":{}}' | nc localhost 7070 | jq --unbuffered -r '
        .LayerChange.new | if . == null or . == "null" then "default" else . end
    '
	# 万が一 nc が終了（切断）した場合は1秒待って再起動
	sleep 1
done
