## users テーブル

| Column             | Type    | Options                     |
| ------------------ | ------- | --------------------------- |
| name               | string  | null: false                 |
| email              | string  | null: false, unique: true   |
| encrypted_password | string  | null: false                 |
| admin              | boolean | null: false, default: false |

### Association

- has_many :articles
- has_many :comments

## articles テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| title              | string     | null: false                    |
| content            | text       | null: false                    |
| user               | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :comments
- has_one_attached :image

## comments テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| text      | text       | null: false                    |
| user      | references | null: false, foreign_key: true |
| article   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :article

## 概要

記事投稿アプリケーション。ユーザーは管理者ユーザーと一般ユーザーに別れている。管理者ユーザーは記事の投稿・編集・削除を行える。一般ユーザーは記事に対するコメント投稿・編集・削除ができる。

## 利用方法

①一覧ページ・詳細ページはログイン不要

②一般ユーザーは画面右上から新規登録もしくはログイン。管理者ユーザーは今回はseedファイルに登録済み。

③一覧ページの画像をクリックすると詳細ページに遷移。ログインの有無、管理者か否かで表示が変わる部分がある。具体的には未ログイン状態であれば、「コメントするにはログインが必要です」の表示。一般ユーザーでログインすればコメント欄表示。管理者ユーザーであれば画像の右下に編集・削除ボタンの表示。

④管理者であれば、記事の投稿者でなくても編集・削除が可能。

⑤画面左上のアプリ名(ArticleApp)を押せば、一覧ページに遷移。

## DEMO

一覧ページと未ログイン状態での詳細ページ
[![Image from Gyazo](https://i.gyazo.com/43c70669f7567fbd2beb4b98f9bcf180.gif)](https://gyazo.com/43c70669f7567fbd2beb4b98f9bcf180)

新規登録(ログイン)ページ
[![Image from Gyazo](https://i.gyazo.com/859353de4dc6600f4868899ae96c1891.gif)](https://gyazo.com/859353de4dc6600f4868899ae96c1891)

管理者ユーザーでのログイン
[![Image from Gyazo](https://i.gyazo.com/064a33baa0ebfdd8c2854d17fb678f7e.gif)](https://gyazo.com/064a33baa0ebfdd8c2854d17fb678f7e)

一般ユーザーでのログイン(非同期によるコメント投稿・編集・削除機能)
[![Image from Gyazo](https://i.gyazo.com/572f299c1b0e1d0dc70ae90e59568ca7.gif)](https://gyazo.com/572f299c1b0e1d0dc70ae90e59568ca7)
[![Image from Gyazo](https://i.gyazo.com/8b845086bfadf111c44224607b2b8d80.gif)](https://gyazo.com/8b845086bfadf111c44224607b2b8d80)

## 工夫した点

- rubocop,localesファイルのテンプレート以外は、全て手書きでの実装であること。
- 不特定多数のユーザー利用を想定し、N + 1 問題を解決するための記述や、javascriptで非同期による機能を一部実装した。非同期での編集・削除機能は完全に未学習の範囲だったため、自ら調べ実装した。
- 第三者が変更を加えることを想定し、管理者機能を導入した。一般ユーザーが投稿ページにアクセスできないよう、コントローラーで振り分けた。

## 改善点など

モーダルウィンドウを実装すれば、より分かりやすくコメントの編集を行える。また、第三者が記事の編集を行った場合に、投稿者に加えて追加表示すれば、記事に誰が関わったのか、ユーザーが判断しやすい。他、検索機能などもあれば、より使いやすいものになる。
