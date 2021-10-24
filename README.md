## 概要

記事投稿アプリケーション。ユーザーは管理者ユーザーと一般ユーザーに別れている。管理者ユーザーは記事の投稿・編集・削除を行える。また、共同編集なども可能。対する一般ユーザーは記事に対するコメント投稿・編集・削除ができる。

## 本番環境

https://article-app-35862.herokuapp.com/

管理者用テストアカウント(メールアドレス / パスワード)
- sam@sam / samsam1
- pra@pra / prapra1

一般ユーザーテストアカウント
- tesu@tesu / tesutesu1
- john@john / johnjohn1

## DEMO

#### トップページと詳細ページ(未ログイン)
[![Image from Gyazo](https://i.gyazo.com/ec1624d196e603bc1c412e362d9fc8ef.gif)](https://gyazo.com/ec1624d196e603bc1c412e362d9fc8ef)
- トップページの画像をクリックすると詳細ページに遷移する
- 未ログイン状態なので、詳細ページに「コメントするにはログインが必要です」の表示

#### 新規登録(ログイン)ページ
[![Image from Gyazo](https://i.gyazo.com/859353de4dc6600f4868899ae96c1891.gif)](https://gyazo.com/859353de4dc6600f4868899ae96c1891)

#### 管理者ユーザーによる記事編集
[![Image from Gyazo](https://i.gyazo.com/1404a76d125f97a96cdd72d11111f880.gif)](https://gyazo.com/1404a76d125f97a96cdd72d11111f880)
- 管理者であれば異なるユーザーでも記事の編集(削除)ができる
- 記事の編集に携わった管理者全員の名前が、記事右下に表示される
- 管理者ユーザーでログインすると、コメント投稿欄が表示されない

#### 一般ユーザーによるコメント非同期投稿・削除(上)と編集(下)
[![Image from Gyazo](https://i.gyazo.com/572f299c1b0e1d0dc70ae90e59568ca7.gif)](https://gyazo.com/572f299c1b0e1d0dc70ae90e59568ca7)
[![Image from Gyazo](https://i.gyazo.com/8b845086bfadf111c44224607b2b8d80.gif)](https://gyazo.com/8b845086bfadf111c44224607b2b8d80)
- 編集ボタンを押した後、キャンセルを押すと編集状態から抜ける
- 編集ボタン→更新を押すと、コメントが更新される。
- 編集時にコメントを全て削除して更新ボタンを押しても、コメントが空にならない(元のまま)
- 自分のコメントにのみ、編集・削除ボタンの表示

## 利用方法

- 管理者ユーザー①でログイン → 投稿するボタンを押し、適切に情報を入力し記事を投稿 → ログアウト
- 一般ユーザー①でログイン → 投稿した記事をクリックし詳細ページへ遷移 → コメントの投稿・編集・削除を実行 → ログアウト
- 管理者ユーザー②でログイン → 投稿した記事をクリックし詳細ページへ遷移 → 編集ボタンを押し、内容を編集して更新 → 削除ボタンを押す → ログアウト

## DB設計

### users テーブル

| Column             | Type    | Options                     |
| ------------------ | ------- | --------------------------- |
| name               | string  | null: false                 |
| email              | string  | null: false, unique: true   |
| encrypted_password | string  | null: false                 |
| admin              | boolean | null: false, default: false |

#### Association

- has_many :article_users
- has_many :articles, through: :article_users
- has_many :comments

### articles テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| title              | string     | null: false                    |
| content            | text       | null: false                    |

#### Association

- has_many :article_users, dependent: :destroy
- has_many :users, through: :article_users
- has_many :comments, dependent: :destroy
- has_one_attached :image

### article_users テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| article | references | null: false, foreign_key: true |
| user    | references | null: false, foreign_key: true |

#### Association

- belongs_to :article
- belongs_to :user

### comments テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| text      | text       | null: false                    |
| user      | references | null: false, foreign_key: true |
| article   | references | null: false, foreign_key: true |

#### Association

- belongs_to :user
- belongs_to :article

## 工夫した点

- 全て手書きのコードで実装した。
- javascriptで非同期によるコメント機能を実装した。非同期での編集・削除機能は完全に未学習の範囲だったため、自ら調べて実装した
- 第三者が変更を加えることを想定し、管理者機能を導入した。一般ユーザーが記事を見たときに、誰が記事の編集に携わったか判断できるよう、中間テーブルを用いて編集者を一覧で表示できるようにした。

## 追加したい機能

- モーダルウインドウなどを実装することで、ユーザーがより分かりやすくコメント編集できる
- 記事検索機能

#### 現在取り組んでいる機能

- ユーザーのアイコン表示