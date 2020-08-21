# テーブル設計

## users テーブル

|Column|Type|Options|
|:--:|:--:|:--:|
|nickname|string|null: false|
|email|string|null: false|
|password|string|null: false|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|birthday|date|null: false|

### Association
* has_many :items
* has_many :item_purchases

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
|sold_out|boolean|null: false, default: false|
|user|references|null: false, foreign_key: true|

### Association
* belongs_to :user
* has_one :item_purchase

## item_purchases テーブル

|Column|Type|Options|
|:--:|:--:|:--:|
|user|references|null: false, foreign_key: true|
|item|references|null: false, foreign_key: true|

### Association
* belongs_to :user
* belongs_to :item
* has_one :address

## addresses テーブル

|Column|Type|Options|
|:--:|:--:|:--:|
|postal_code|string|null: false|
|prefecture_id|integer|null: false|
|city|string|null: false|
|address|string|null: false|
|building|string||
|phone_number|string|null: false|
|item_purchase|references|null: false, foreign_key: true|

### Association
* belongs_to :item_purchase
