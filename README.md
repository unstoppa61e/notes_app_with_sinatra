# My Notes

'My Notes' は、ブラウザで利用できるメモアプリです。

# デモ

メモの作成、変更、削除といった機能を備えています。

![](https://user-images.githubusercontent.com/46347198/123735753-bbca4e80-d8da-11eb-8d8d-e422e5d4befc.gif)

# 特徴

My Notes は Sinatra で作成されています。

# インストール & 起動
1. ターミナルにて、`ruby -v`を実行し、バージョンを確認してください。
もし、`ruby: command not found`と表示される場合、PC に Ruby をインストールしてください。
 

2. お好みの方法で、`Sinatra`と`WEBrick`という Gem をインストールしてください（※Ruby のバージョンが 2.7 系以前の場合、`WEBrick`は不要）。
よく分からない場合は、以下のコマンドをコピー＆ペーストし、実行してください。
```bash
gem install sinatra webrick
```

   
3. ターミナルにて、以下のコマンドを実行してください。
```
git clone https://github.com/monoue/notes_app_with_sinatra.git my_notes && ./my_notes/my_notes.rb -o 0.0.0.0 
```

4. ブラウザにて、http://localhost:4567/home を開いてください。

# 使用方法
## 新規メモの追加
   1. ホーム画面右上の`追加`ボタンをクリック
   2. 〈名前〉欄と〈内容〉欄を入力
   3. 画面下の`保存`ボタンをクリック
   

## メモ内容の確認
   - ホーム画面にて、確認したいメモの名前をクリック
   

## メモ内容の変更
   1. ホーム画面にて、確認したいメモの名前をクリック
   2. `変更`ボタンをクリック
   3. 変更したい項目をクリックし、情報を更新
   4. `保存`ボタンをクリック
   

## メモの削除
   1. ホーム画面にて、確認したいメモの名前をクリック
   2. `削除`ボタンをクリック

# 作者

* unstoppa61e
* ブログ: https://unstoppa61e.hatenablog.com/
