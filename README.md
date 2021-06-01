## users テーブル

| Column                          | Type   | Options     |
| ------------------------------- | ------ | ------------|
| nickname                        | string | null: false |
| email                           | string | null: false |
| encrypted_password              | string | null: false |
| encrypted_password_confirmation | string | null: false |
| name                            | string | null: false |
| katakana_name                   | string | null: false |
| birth_day                       | string | null: false |

### Association
- has_many :items
- has_many :purchases

## items テーブル

| Column           | Type       | Options                        |
| -----------------| ---------- | -------------------------------|
| name             | string     | null: false                    |
| description      | text       | null: false                    |
| categry          | string     | null: false                    |
| status           | string     | null: false                    |
| shipping_charges | string     | null: false                    |
| days_to_ship     | string     | null: false                    |
| price            | integer    | null: false                    |
| user             | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :purchases

## purchases テーブル

| Column           | Type       | Options                        |
| -----------------| ---------- | -------------------------------|
| card_information | string     | null: false                    |
| expiration_date  | string     | null: false                    |
| security_code    | string     | null: false                    |
| user             | references | null: false, foreign_key: true |
| item             | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :shipping_address

## shipping_addresses テーブル

| Column        | Type       | Options                        |
| --------------| ---------- | -------------------------------|
| postal_code   | string     | null: false                    |
| prefectures   | string     | null: false                    |
| address       | string     | null: false                    |
| building name | string     | null: false                    |
| phone_number  | string     | null: false                    |
| purchases     | references | null: false, foreign_key: true |

### Association
- belongs_to :purchases
