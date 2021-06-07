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
        expect(@item.errors.full_messages).to include("Category is not a number")
      end
      it '商品の状態の情報が必須であること。' do
        @item.status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Status is not a number")
      end
      it '配送料の負担の情報が必須であること。' do
        @item.shipping_charge_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping charge is not a number")
      end
      it '発送元の地域の情報が必須であること。' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture is not a number")
      end
      it '発送までの日数の情報が必須であること。' do
        @item.days_to_ship_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Days to ship is not a number")
      end
      it '価格の情報が必須であること。' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it '価格は半角数値のみ保存可能であること。(全角文字Ver)' do
        @item.price = '全角'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it '価格は半角数値のみ保存可能であること。(全角ALPABETVer)' do
        @item.price = 'ALPABET'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it '価格は半角数値のみ保存可能であること。(全角数字Ver)' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it '価格は半角数値のみ保存可能であること。(半角文字Ver)' do
        @item.price = 'ﾊﾝｶｸ'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it '価格は半角数値のみ保存可能であること。(半角alphabetVer)' do
        @item.price = 'alphabet'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it '価格は、¥300~¥9,999,999の間のみ保存可能であること。(300以下Ver)' do
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end
      it '価格は、¥300~¥9,999,999の間のみ保存可能であること。(9,999,999以上Ver)' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end
      it '' do
        
      end
      it '' do
        
      end
      it '' do
        
      end
      it '' do
        
      end
      it '' do
        
      end
      it '' do
        
      end
      it '' do
        
      end
      it '' do
        
      end
      it '' do
        
      end
    end
      
  end
end

# - 必要な情報を適切に入力して「出品する」ボタンを押すと、商品情報がデータベースに保存されること。
# - ログイン状態の場合のみ、商品出品ページへ遷移できること。
# - ログアウト状態の場合は、商品出品ページへ遷移しようとすると、ログインページへ遷移すること。
# - 
# - 
# - 
# - 
# - カテゴリーは、「---、メンズ、レディース、ベビー・キッズ、インテリア・住まい・小物、本・音楽・ゲーム、おもちゃ・ホビー・グッズ、家電・スマホ・カメラ、スポーツ・レジャー、ハンドメイド、その他」の11項目が表示されること（--- は初期値として設定すること）。
# - 
# - 商品の状態は、「---、新品・未使用、未使用に近い、目立った傷や汚れなし、やや傷や汚れあり、傷や汚れあり、全体的に状態が悪い」の7項目が表示されること（--- は初期値として設定すること）。
# - 
# - 配送料の負担は、「---、着払い(購入者負担)、送料込み(出品者負担)」の3項目が表示されること（--- は初期値として設定すること）。
# - 
# - 発送元の地域は、「---」と47都道府県の合計48項目が表示されること（--- は初期値として設定すること）。
# - 
# - 発送までの日数は、「---、1~2日で発送、2~3日で発送、4~7日で発送」の4項目が表示されること（--- は初期値として設定すること）。
# - 
# - 
# - 
# - 入力された価格によって、販売手数料や販売利益の表示が変わること。
# - エラーハンドリングができること（入力に問題がある状態で「出品する」ボタンが押された場合、情報は保存されず、出品ページに戻りエラーメッセージが表示されること）。
# - エラーハンドリングによって出品ページに戻った場合でも、入力済みの項目（商品画像・販売手数料・販売利益以外）は消えないこと。
# - エラーハンドリングの際、重複したエラーメッセージが表示されないこと。