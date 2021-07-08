# フリーマーケットアプリ
## アプリケーション概要
フリーマーケットのアプリケーションを作成しました。ユーザーを登録すると商品を出品できるようになります。自身が出品した商品は、編集と削除をすることができます。他のユーザーが出品した商品は、クレジットカードを用いて購入することができます。

## URL
http://3.130.182.31/

## テスト用アカウント
### Basic認証
ID: admin
Pass: 2222
### ログインできるアカウント
#### 出品者
Email: shentianzhiyi@gmail.com  
パスワード: Seller01
#### 購入者
Email kandakandaa2@gmail.com  
パスワード consumer01

## 利用方法	

## 目指した課題解決
個人間での、売買ができるようにしたかった。

## 洗い出した要件
- デプロイ機能の実装
- Basic認証の導入
- データベース設計
- ユーザー管理機能の実装
- 商品出品機能の実装
- 商品一覧表示機能の実装
- 商品詳細表示機能の実装
- 商品情報編集機能の実装
- 商品削除機能の実装
- 商品購入機能の実装
- S3の導入
- EC2の導入
- 複数の画像投稿機能の実装
- エラーメッセージの日本語化
- 購入の簡易化
- コメント機能の実装
- ウィザード形式のユーザー管理機能の実装
- タグ付け機能の実装
- 複雑な検索機能の実装
- パンくず機能の実装

実装した機能についての画像やGIFおよびその説明	実装した機能について、それぞれどのような特徴があるのかを列挙する形で記述。画像はGyazoで、GIFはGyazoGIFで撮影すること。

## データベース設計
[![Image from Gyazo](https://i.gyazo.com/0c3053846595066e9681f609bbcf960b.jpg)](https://gyazo.com/0c3053846595066e9681f609bbcf960b)

## ローカルでの動作方法	
### ローカルで動作をさせるまでに必要なコマンド
- git clone https://github.com/kandanaoki/furima-35832.git
- cd furima-35832
- bundle install
- yarn install
### 開発環境
- Ruby(2.6.5)
- HTML
- CSS
- JavaScript
- Rails(6.0.0)
- MySQL2(0.4.4)
- Github
- AWS
- Visual Studio Code


## テーブル設計

### users テーブル

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

#### Association
- has_many :items
- has_many :purchases
- has_many :comments
- has_one :shipping_address
- has_one :card

### items テーブル

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

#### Association
- belongs_to :user
- has_one :purchase
- has_many_attached :images
- has_many :comments
- has_many :item_tag_relations
- has_many :tags


### purchases テーブル

| Column           | Type       | Options                        |
| -----------------| ---------- | -------------------------------|
| user             | references | null: false, foreign_key: true |
| item             | references | null: false, foreign_key: true |

#### Association
- belongs_to :user
- belongs_to :item

### shipping_addresses テーブル

| Column         | Type       | Options                        |
| ---------------| ---------- | -------------------------------|
| postal_code    | string     | null: false                    |
| prefecture_id  | integer    | null: false                    |
| city           | string     | null: false                    |
| address        | string     | null: false                    |
| building_name  | string     |                                |
| phone_number   | string     | null: false                    |
| user           | references | null: false, foreign_key: true |

#### Association
- belongs_to :user

### cards テーブル

| Column         | Type       | Options                        |
| ---------------| ---------- | -------------------------------|
| customer_token | string     | null: false                    |
| user           | references | null: false, foreign_key: true |

#### Association
- belongs_to :user

### comments テーブル

| Column | Type       | Options                        |
| -------| ---------- | -------------------------------|
| text   | string     |                                |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

#### Association
- belongs_to :user
- belongs_to :item

### item_tag_relations テーブル

| Column | Type       | Options                        |
| -------| ---------- | -------------------------------|
| item   | references | null: false, foreign_key: true |
| tag    | references | null: false, foreign_key: true |

#### Association
- belongs_to :item
- belongs_to :tag

### tags テーブル

| Column   | Type       | Options                        |
| ---------| ---------- | -------------------------------|
| tag_name | references | null: false, uniqueness: true  |

#### Association
- has_many :item_tag_relations
- has_many :items

