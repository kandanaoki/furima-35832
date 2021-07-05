require 'rails_helper'

RSpec.describe ItemTag, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item_tag = FactoryBot.build(:item_tag)
    @item_tag.images = fixture_file_upload('public/images/test_image.png')
  end
  describe '商品出荷機能' do
    context '商品出荷機能の正常系' do
      it '必要な情報を入力すると出荷できること' do
        expect(@item_tag).to be_valid
      end

      it 'タグがなくても出荷できること' do
        @item_tag.tag_name = ''
        expect(@item_tag).to be_valid
      end
    end

    context '商品出荷機能の異常系' do
      it '商品画像を1枚つけることが必須であること。' do
        @item_tag.images = nil
        @item_tag.valid?
        expect(@item_tag.errors.full_messages).to include("画像を入力してください")
      end
      it '商品名が必須であること。' do
        @item_tag.name = ''
        @item_tag.valid?
        expect(@item_tag.errors.full_messages).to include("商品名を入力してください")
      end
      it '商品の説明が必須であること。' do
        @item_tag.description = ''
        @item_tag.valid?
        expect(@item_tag.errors.full_messages).to include("商品の説明を入力してください")
      end
      it 'カテゴリーの情報が必須であること。' do
        @item_tag.category_id = ''
        @item_tag.valid?
        expect(@item_tag.errors.full_messages).to include('カテゴリーは数値で入力してください')
      end
      it '商品の状態の情報が必須であること。' do
        @item_tag.status_id = ''
        @item_tag.valid?
        expect(@item_tag.errors.full_messages).to include('商品の状態は数値で入力してください')
      end
      it '配送料の負担の情報が必須であること。' do
        @item_tag.shipping_charge_id = ''
        @item_tag.valid?
        expect(@item_tag.errors.full_messages).to include('配送料の負担は数値で入力してください')
      end
      it '発送元の地域の情報が必須であること。' do
        @item_tag.prefecture_id = ''
        @item_tag.valid?
        expect(@item_tag.errors.full_messages).to include('発送元の地域は数値で入力してください')
      end
      it '発送までの日数の情報が必須であること。' do
        @item_tag.days_to_ship_id = ''
        @item_tag.valid?
        expect(@item_tag.errors.full_messages).to include('発送までの日数は数値で入力してください')
      end
      it '価格の情報が必須であること。' do
        @item_tag.price = ''
        @item_tag.valid?
        expect(@item_tag.errors.full_messages).to include('販売価格は数値で入力してください')
      end
      it '価格は半角数値のみ保存可能であること。(全角文字Ver)' do
        @item_tag.price = '全角'
        @item_tag.valid?
        expect(@item_tag.errors.full_messages).to include('販売価格は数値で入力してください')
      end
      it '価格は半角数値のみ保存可能であること。(全角ALPABETVer)' do
        @item_tag.price = 'ALPABET'
        @item_tag.valid?
        expect(@item_tag.errors.full_messages).to include('販売価格は数値で入力してください')
      end
      it '価格は半角数値のみ保存可能であること。(全角数字Ver)' do
        @item_tag.price = '３００'
        @item_tag.valid?
        expect(@item_tag.errors.full_messages).to include('販売価格は数値で入力してください')
      end
      it '価格は半角数値のみ保存可能であること。(半角文字Ver)' do
        @item_tag.price = 'ﾊﾝｶｸ'
        @item_tag.valid?
        expect(@item_tag.errors.full_messages).to include('販売価格は数値で入力してください')
      end
      it '価格は半角数値のみ保存可能であること。(半角alphabetVer)' do
        @item_tag.price = 'alphabet'
        @item_tag.valid?
        expect(@item_tag.errors.full_messages).to include('販売価格は数値で入力してください')
      end
      it '販売価格が半角英数字混合だと登録できないこと' do
        @item_tag.price = '300alphabet'
        @item_tag.valid?
        expect(@item_tag.errors.full_messages).to include('販売価格は数値で入力してください')
      end
      it '価格は、¥300~¥9,999,999の間のみ保存可能であること。(300以下Ver)' do
        @item_tag.price = 299
        @item_tag.valid?
        expect(@item_tag.errors.full_messages).to include('販売価格は300以上の値にしてください')
      end
      it '価格は、¥300~¥9,999,999の間のみ保存可能であること。(9,999,999以上Ver)' do
        @item_tag.price = 10_000_000
        @item_tag.valid?
        expect(@item_tag.errors.full_messages).to include('販売価格は9999999以下の値にしてください')
      end
      it 'category_idが1以外であること' do
        @item_tag.category_id = 1
        @item_tag.valid?
        expect(@item_tag.errors.full_messages).to include('カテゴリーは1以外の値にしてください')
      end
      it 'status_idが1以外であること' do
        @item_tag.status_id = 1
        @item_tag.valid?
        expect(@item_tag.errors.full_messages).to include('商品の状態は1以外の値にしてください')
      end
      it 'shipping_charge_idが1以外であること' do
        @item_tag.shipping_charge_id = 1
        @item_tag.valid?
        expect(@item_tag.errors.full_messages).to include('配送料の負担は1以外の値にしてください')
      end
      it 'prefecture_idが1以外であること' do
        @item_tag.prefecture_id = 1
        @item_tag.valid?
        expect(@item_tag.errors.full_messages).to include('発送元の地域は1以外の値にしてください')
      end
      it 'days_to_ship_idが1以外であること' do
        @item_tag.days_to_ship_id = 1
        @item_tag.valid?
        expect(@item_tag.errors.full_messages).to include('発送までの日数は1以外の値にしてください')
      end
    end
  end
end
