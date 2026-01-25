#!/bin/bash

# wf-recorder のプロセス ID を取得
PID=$(pgrep -x wf-recorder)

if [ -n "$PID" ]; then
	# プロセスの開始時間を取得（現在の時刻との差分を計算）
	# ※psコマンドで経過秒数(etimes)を取得
	SECONDS_ELAPSED=$(ps -o etimes= -p "$PID" | tr -d ' ')

	# 秒を 分:秒 (MM:SS) 形式に変換
	MINUTES=$((SECONDS_ELAPSED / 60))
	SECONDS=$((SECONDS_ELAPSED % 60))

	# 表示用のテキストを出力
	printf "󰑋 %02d:%02d\n" "$MINUTES" "$SECONDS"
else
	# 実行中でなければ何も表示しない
	echo ""
fi
