# zone-lint.sh
simple cheker for a BIND zone file.

こちらは town-ci 内のプライベートリポジトリ版です。
社内特有のチェック内容などはこちらに実装していきます。

## 使い方

./zone-lint.sh /path/to/zonefile

## チェック項目

(1)シリアル番号を表示します

(2)NS, MX, CNAMEのレコードについて末尾に . が付いているか確認します

(3)全角文字が含まれていないか確認します

## 動作環境

AlmaLinux8
grep, sed, util-linux
同じディレクトリに txtformatter.sh があること

