#!/usr/bin/env bash
# ble.sh 初期化設定 (~/.config/blesh/init.sh)

# ------------------------------------------------------------------------------
# 複数行編集 (MULTILINE) における Enter (RET / C-m) の挙動設定
# ------------------------------------------------------------------------------
# ble.sh ではデフォルトで、コマンドラインに改行が含まれる複数行モードの場合、
# RET (C-m) が改行の挿入になり、コマンド実行には C-j を押す必要があります。
#
# 下記の設定 (accept-line syntax) により、構文が完成していれば複数行であっても
# Enter (RET / C-m) でそのまま実行できるようになり、C-j を押す必要がなくなります。
# なお、構文が未完成（未クローズのクォートや if / for ブロックの途中など）の時は、
# Enter を押すと自動的に改行が挿入されます。

# Emacs モード用
ble-bind -m emacs -f 'RET' 'accept-line syntax'
ble-bind -m emacs -f 'C-m' 'accept-line syntax'

# Vi モード用 (編集モード / ノーマルモード)
ble-bind -m vi_imap -f 'RET' 'accept-line syntax'
ble-bind -m vi_imap -f 'C-m' 'accept-line syntax'
ble-bind -m vi_nmap -f 'RET' 'accept-line syntax'
ble-bind -m vi_nmap -f 'C-m' 'accept-line syntax'

# 構文が完成している状態でも明示的に改行を挿入したい場合 (Alt+Enter)
ble-bind -m emacs -f 'M-RET' newline
ble-bind -m vi_imap -f 'M-RET' newline

# ------------------------------------------------------------------------------
# （参考）構文チェックを行わず、常に Enter で即時実行したい場合 (通常の Bash と同様の挙動):
# ble-bind -m emacs -f 'RET' 'accept-line'
# ble-bind -m emacs -f 'C-m' 'accept-line'
# ble-bind -m vi_imap -f 'RET' 'accept-line'
# ble-bind -m vi_imap -f 'C-m' 'accept-line'
# ble-bind -m vi_nmap -f 'RET' 'accept-line'
# ble-bind -m vi_nmap -f 'C-m' 'accept-line'
# ------------------------------------------------------------------------------
