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
個人間での、売買できるようにしたいと考えました。

## 洗い出した要件
- デプロイ機能の実装
- Basic認証の導入  
アプリを使えるユーザーを制限しました。
[![Image from Gyazo](https://i.gyazo.com/8abdef9869de7712082e98483d57155e.png)](https://gyazo.com/8abdef9869de7712082e98483d57155e)
- データベース設計
- ユーザー管理機能の実装  
ユーザーの登録、ログイン、ログアウトを可能にしました。
- 商品出品機能の実装  
商品を出品できるようにしました。
[![Image from Gyazo](https://i.gyazo.com/c862f8bb32fd4d846d0b5576dbd1ebaf.gif)](https://gyazo.com/c862f8bb32fd4d846d0b5576dbd1ebaf)
- 商品一覧表示機能の実装  
ホーム画面で出品された商品を一覧表示できるようにしました。
- 商品詳細表示機能の実装  
商品をクリックすると商品の詳細ページに行けるようにしました。
[![Image from Gyazo](https://i.gyazo.com/d1aed2f03c39d4f8dd06fa56a7ae2982.gif)](https://gyazo.com/d1aed2f03c39d4f8dd06fa56a7ae2982)
- 商品情報編集機能の実装  
自分が出品した商品を編集できるようにしました。
[![Image from Gyazo](https://i.gyazo.com/a5ab975e0220c8631c40f34c0fcc6c8b.gif)](https://gyazo.com/a5ab975e0220c8631c40f34c0fcc6c8b)
- 商品削除機能の実装  
自分が出品した商品を削除できるようにしました。
[![Image from Gyazo](https://i.gyazo.com/2b9ff6124340c5cc9e9bed45c5a63ab8.gif)](https://gyazo.com/2b9ff6124340c5cc9e9bed45c5a63ab8)
- 商品購入機能の実装  
出品していないユーザーが、商品を購入できるようにしました。
- S3の導入
- EC2の導入  
サーバーをHerokuからAWSに変更しました。
- 複数の画像投稿機能の実装  
1つの商品につき複数の写真を添付できるようにしました。
[![Image from Gyazo](https://i.gyazo.com/9839b95d8d8c37dee4aa88a8cc40a2b9.jpg)](https://gyazo.com/9839b95d8d8c37dee4aa88a8cc40a2b9)
- エラーメッセージの日本語化  
エラーメッセージを日本語化しました。
[![Image from Gyazo](https://i.gyazo.com/af53f0ab262da2cbd1a51a20a0416644.gif)](https://gyazo.com/af53f0ab262da2cbd1a51a20a0416644)
- 購入の簡易化  
ワンクリックで購入できるようにしました。
[![Image from Gyazo](https://i.gyazo.com/50357e7740ecbcc373ac9191fe21cdaf.gif)](https://gyazo.com/50357e7740ecbcc373ac9191fe21cdaf)
- コメント機能の実装  
商品に対してコメントできるようにしました。
- ウィザード形式のユーザー管理機能の実装  
ユーザー登録、住所、カード番号を一度に登録できるようにしました。
[![Image from Gyazo](https://i.gyazo.com/666f0ab4b89a0b2029a6c143eddd34b7.gif)](https://gyazo.com/666f0ab4b89a0b2029a6c143eddd34b7)
- タグ付け機能の実装  
商品にタグ付けできるようにしました。
[![Image from Gyazo](https://i.gyazo.com/8a205ba5951912a18c3cabfdd4284bea.jpg)](https://gyazo.com/8a205ba5951912a18c3cabfdd4284bea)
- 複雑な検索機能の実装  
商品を限定して検索できるようにしました。
[![Image from Gyazo](https://i.gyazo.com/055e055e8f6552b47f8f3a265fbf7bf9.gif)](https://gyazo.com/055e055e8f6552b47f8f3a265fbf7bf9)
- パンくず機能の実装  
たどってきたページが一目でわかるようにしました
[![Image from Gyazo](https://i.gyazo.com/67564f8994e32602d5510e7121a848b7.jpg)](https://gyazo.com/67564f8994e32602d5510e7121a848b7)
[![Image from Gyazo](https://i.gyazo.com/a29b3c2038b682a5a30fb12615c45970.png)](https://gyazo.com/a29b3c2038b682a5a30fb12615c45970)

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

