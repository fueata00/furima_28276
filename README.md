# テーブル設計

## users テーブル

|Column|Type|Options|
|:--:|:--:|:--:|
|nickname|string|null: false|
|email|string|null: false|
|password|string|null: false|
|firts_name|string|null: false|
|last_name|string|null: false|
|birthday|date|null: false|

### Association
* has_many :items

## items テーブル

|Column|Type|Options|
|:--:|:--:|:--:|
|name|string|null: false|
|text|text|null: false|
|category_id|integer|null: false|
|status_id|integer|null: false|
|shipping_fee_id|integer|null: false|
|prefecture_id|integer|null: false|
|shipping_time_id|integer|null: false|
|price|integer|null: false|
|user_id|references|null: false, foreign_key: true|

### Association
* belongs_to :user
* has_one :item_purchases

## item_purchases テーブル

|Column|Type|Options|
|:--:|:--:|:--:|
|purchace|boolean||
|item_id|references|null: false, foreign_key: true|

### Association
* belongs_to :item
* has_one :address

## addresses テーブル

|Column|Type|Options|
|:--:|:--:|:--:|
|postal_code|string|null: false|
|prefecture_id|intger|null: false|
|city|string|null: false|
|address|string|null: false|
|building|string|null: false|
|phone_number|string|null: false|
|item_purchase_id|references|null: false, foreign_key: true|

### Association
* belongs_to :item_purchase
