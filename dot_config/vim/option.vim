" --- 基本設定 ---
set autoread  " ファイルを自動的に読み込む
set ambiwidth=double  " 2バイト文字を正しく描画する
set cmdheight=1  " メッセージ表示欄の高さを1行に設定
set encoding=utf-8  " ファイルのエンコーディングをUTF-8に設定
set hidden  " 編集中のファイルを保存せずに別のファイルを開くことを許可する
set nobackup  " バックアップファイルを作成しない


" --- 表示設定 ---
set cursorcolumn  " カーソル列をハイライト表示する
set cursorline  " カーソル行をハイライト表示する
set emoji  " 絵文字を表示する
set laststatus=2  " 常にステータスラインを表示する
set list  " 不可視文字を表示する
set listchars=tab:¦\ ,trail:･  " 不可視文字の表示形式を設定する
set number  " 行番号を表示する
set showcmd  " コマンドを表示する
set showmatch  " 対応する括弧を強調表示する
syntax enable  " シンタックスハイライトを有効にする


" --- 検索設定 ---
set hlsearch  " 検索に一致した部分をハイライト表示する
set ignorecase  " 検索時に大文字と小文字を区別しない
set incsearch  " インクリメンタルサーチを有効にする
set smartcase  " 検索パターンに大文字が含まれている場合のみ、大文字と小文字を区別する
set wrapscan  " 検索時にファイルの末尾に達したら、先頭から検索を続ける


" --- インデント設定 ---
set autoindent  " 自動インデントを有効にする
set expandtab  " タブ文字をスペースに展開する
set shiftwidth=4  " インデントの幅を4文字に設定
set smartindent  " スマートインデントを有効にする
set tabstop=4  " タブ文字の幅を4文字に設定


" --- その他 ---
set clipboard=unnamedplus  " システムのクリップボードと連携する
set mouse=a  " マウスの使用を有効にする
set nowrap  " 行の折り返しを無効にする
set signcolumn=yes  " 符号列を常に表示する
set swapfile  " スワップファイルを作成する
set virtualedit=onemore  " カーソルを行末より1文字分右に移動できるようにする
set wildmode=list:longest  " 補完候補をリスト表示する

