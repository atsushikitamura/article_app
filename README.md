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
| image              | text       | null: false                    |
| title              | string     | null: false                    |
| content            | text       | null: false                    |
| user               | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :comments

## comments テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| text      | text       | null: false                    |
| user      | references | null: false, foreign_key: true |
| article   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :article