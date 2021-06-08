require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe '商品出荷機能' do
    context '商品出荷機能の正常系' do
      it '必要な情報を入力すると出荷できること' do
        expect(@item).to be_valid
      end
    end

    context '' do
      it '商品画像を1枚つけることが必須であること。' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名が必須であること。' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it '商品の説明が必須であること。' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it 'カテゴリーの情報が必須であること。' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Category is not a number')
      end
      it '商品の状態の情報が必須であること。' do
        @item.status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Status is not a number')
      end
      it '配送料の負担の情報が必須であること。' do
        @item.shipping_charge_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping charge is not a number')
      end
      it '発送元の地域の情報が必須であること。' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture is not a number')
      end
      it '発送までの日数の情報が必須であること。' do
        @item.days_to_ship_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Days to ship is not a number')
      end
      it '価格の情報が必須であること。' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it '価格は半角数値のみ保存可能であること。(全角文字Ver)' do
        @item.price = '全角'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it '価格は半角数値のみ保存可能であること。(全角ALPABETVer)' do
        @item.price = 'ALPABET'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it '価格は半角数値のみ保存可能であること。(全角数字Ver)' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it '価格は半角数値のみ保存可能であること。(半角文字Ver)' do
        @item.price = 'ﾊﾝｶｸ'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it '価格は半角数値のみ保存可能であること。(半角alphabetVer)' do
        @item.price = 'alphabet'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it '販売価格が半角英数字混合だと登録できないこと' do
        @item.price = '300alphabet'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it '価格は、¥300~¥9,999,999の間のみ保存可能であること。(300以下Ver)' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end
      it '価格は、¥300~¥9,999,999の間のみ保存可能であること。(9,999,999以上Ver)' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end
      it 'category_idが1以外であること' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 1')
      end
      it 'status_idが1以外であること' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Status must be other than 1')
      end
      it 'shipping_charge_idが1以外であること' do
        @item.shipping_charge_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping charge must be other than 1')
      end
      it 'prefecture_idが1以外であること' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture must be other than 1')
      end
      it 'days_to_ship_idが1以外であること' do
        @item.days_to_ship_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Days to ship must be other than 1')
      end
    end
  end
end
