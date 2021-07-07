## users テーブル

| Column                          | Type   | Options                    |
| ------------------------------- | ------ | ---------------------------|
| nickname                        | string | null: false                |
| email                           | string | null: false, unique: true  |
| encrypted_password              | string | null: false                |
| first_name                      | string | null: false                |
| last_name                       | string | null: false                |
| first_name_kana                 | string | null: false                |
| last_name_kana                  | string | null: false                |
| birth_date                      | date   | null: false                |

### Association
- has_many :items
- has_many :purchases
- has_many :comments
- has_one :shipping_address
- has_one :card

## items テーブル

| Column              | Type       | Options                        |
| --------------------| ---------- | -------------------------------|
| name                | string     | null: false                    |
| description         | text       | null: false                    |
| category_id         | integer    | null: false                    |
| status_id           | integer    | null: false                    |
| shipping_charge_id  | integer    | null: false                    |
| prefecture_id       | integer    | null: false                    |
| days_to_ship_id     | integer    | null: false                    |
| price               | integer    | null: false                    |
| user                | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :purchase
- has_many_attached :images
- has_many :comments
- has_many :item_tag_relations
- has_many :tags


## purchases テーブル

| Column           | Type       | Options                        |
| -----------------| ---------- | -------------------------------|
| user             | references | null: false, foreign_key: true |
| item             | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item

## shipping_addresses テーブル

| Column         | Type       | Options                        |
| ---------------| ---------- | -------------------------------|
| postal_code    | string     | null: false                    |
| prefecture_id  | integer    | null: false                    |
| city           | string     | null: false                    |
| address        | string     | null: false                    |
| building_name  | string     |                                |
| phone_number   | string     | null: false                    |
| user           | references | null: false, foreign_key: true |

### Association
- belongs_to :user

## cards テーブル

| Column         | Type       | Options                        |
| ---------------| ---------- | -------------------------------|
| customer_token | string     | null: false                    |
| user           | references | null: false, foreign_key: true |

### Association
- belongs_to :user

## comments テーブル

| Column | Type       | Options                        |
| -------| ---------- | -------------------------------|
| text   | string     |                                |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item

## item_tag_relations テーブル

| Column | Type       | Options                        |
| -------| ---------- | -------------------------------|
| item   | references | null: false, foreign_key: true |
| tag    | references | null: false, foreign_key: true |

### Association
- belongs_to :item
- belongs_to :tag

## tags テーブル

| Column   | Type       | Options                        |
| ---------| ---------- | -------------------------------|
| tag_name | references | null: false, uniqueness: true  |

### Association
- has_many :item_tag_relations
- has_many :items

