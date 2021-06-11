require 'rails_helper'

RSpec.describe PurchaseShippingAdress, type: :model do
  before do
    @purchase_shipping_adress = FactoryBot.build(:purchase_shipping_adress)
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
  end

  describe '商品購入機能の実装' do
    context '商品購入機能の実装の正常系' do
      it '情報が全部あれば、商品の購入ができること。' do
        expect(@purchase_shipping_adress).to be_valid
      end
      it '建物名は任意であること。' do
        expect(@purchase_shipping_adress).to be_valid
      end
    end

    context '商品購入機能の実装の異常系' do
      it 'user_idがないと、商品の購入ができないこと。' do
        @purchase_shipping_adress.user_id = ''
        @purchase_shipping_adress.valid?
        expect(@purchase_shipping_adress.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idがないと、商品の購入ができないこと。' do
        @purchase_shipping_adress.item_id = ''
        @purchase_shipping_adress.valid?
        expect(@purchase_shipping_adress.errors.full_messages).to include("Item can't be blank")
      end
      it 'tokenがないと、商品の購入ができないこと。' do
        @purchase_shipping_adress.token = ''
        @purchase_shipping_adress.valid?
        expect(@purchase_shipping_adress.errors.full_messages).to include("Token can't be blank")
      end
      it '郵便番号が必須であること。' do
        @purchase_shipping_adress.postal_code = ''
        @purchase_shipping_adress.valid?
        expect(@purchase_shipping_adress.errors.full_messages).to include("Postal code can't be blank")
      end
      it '郵便番号は、「3桁ハイフン4桁」の半角文字列のみ保存可能なこと（良い例：123-4567 良くない例：1234567）。' do
        @purchase_shipping_adress.postal_code = '1234567'
        @purchase_shipping_adress.valid?
        expect(@purchase_shipping_adress.errors.full_messages).to include("Postal code is invalid")
      end
      it '郵便番号は、「3桁ハイフン4桁」の半角文字列のみ保存可能なこと（良い例：123-4567 良くない例：123-4567）。' do
        @purchase_shipping_adress.postal_code = '１２３-４５６'
        @purchase_shipping_adress.valid?
        expect(@purchase_shipping_adress.errors.full_messages).to include("Postal code is invalid")
      end
      it '郵便番号は、「3桁ハイフン4桁」の半角文字列のみ保存可能なこと（良い例：123-4567 良くない例：abc-defg）。' do
        @purchase_shipping_adress.postal_code = 'abc-defg'
        @purchase_shipping_adress.valid?
        expect(@purchase_shipping_adress.errors.full_messages).to include("Postal code is invalid")
      end
      it '郵便番号は、「3桁ハイフン4桁」の半角文字列のみ保存可能なこと（良い例：123-4567 良くない例：ABC-DEFG）。' do
        @purchase_shipping_adress.postal_code = 'ABC-DEFG'
        @purchase_shipping_adress.valid?
        expect(@purchase_shipping_adress.errors.full_messages).to include("Postal code is invalid")
      end
      it '郵便番号は、「3桁ハイフン4桁」の半角文字列のみ保存可能なこと（良い例：123-4567 良くない例：あいう-えおかき）。' do
        @purchase_shipping_adress.postal_code = 'あいう-えおかき'
        @purchase_shipping_adress.valid?
        expect(@purchase_shipping_adress.errors.full_messages).to include("Postal code is invalid")
      end
      it '郵便番号は、「3桁ハイフン4桁」の半角文字列のみ保存可能なこと（良い例：123-4567 良くない例：ｱｲｳ-ｴｵｶｷ）。' do
        @purchase_shipping_adress.postal_code = 'ｱｲｳ-ｴｵｶｷ'
        @purchase_shipping_adress.valid?
        expect(@purchase_shipping_adress.errors.full_messages).to include("Postal code is invalid")
      end
      it '郵便番号は、「3桁ハイフン4桁」の半角文字列のみ保存可能なこと（良い例：123-4567 良くない例：アイウ-エオカキ）。' do
        @purchase_shipping_adress.postal_code = 'アイウ-エオカキ'
        @purchase_shipping_adress.valid?
        expect(@purchase_shipping_adress.errors.full_messages).to include("Postal code is invalid")
      end
      it '郵便番号は、「3桁ハイフン4桁」の半角文字列のみ保存可能なこと（良い例：123-4567 良くない例：一二三-四五六七）。' do
        @purchase_shipping_adress.postal_code = '一二三-四五六七'
        @purchase_shipping_adress.valid?
        expect(@purchase_shipping_adress.errors.full_messages).to include("Postal code is invalid")
      end
      it '都道府県が必須であること。' do
        @purchase_shipping_adress.prefecture_id = ''
        @purchase_shipping_adress.valid?
        expect(@purchase_shipping_adress.errors.full_messages).to include("Prefecture is not a number")
      end
      it '市区町村が必須であること。' do
        @purchase_shipping_adress.city = ''
        @purchase_shipping_adress.valid?
        expect(@purchase_shipping_adress.errors.full_messages).to include("City can't be blank")
      end
      it '番地が必須であること。' do
        @purchase_shipping_adress.address = ''
        @purchase_shipping_adress.valid?
        expect(@purchase_shipping_adress.errors.full_messages).to include("Address can't be blank")
      end
      it '電話番号が必須であること。' do
        @purchase_shipping_adress.phone_number = ''
        @purchase_shipping_adress.valid?
        expect(@purchase_shipping_adress.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号は、10桁以上11桁以内の半角数値のみ保存可能なこと（良い例：09012345678 良くない例：090-1234-5678）。' do
        @purchase_shipping_adress.phone_number = '090-1234-5678'
        @purchase_shipping_adress.valid?
        expect(@purchase_shipping_adress.errors.full_messages).to include("Phone number is invalid")
      end
      it '電話番号は、10桁以上11桁以内の半角数値のみ保存可能なこと（良い例：09012345678 良くない例：０９０１２３４５６７８）。' do
        @purchase_shipping_adress.phone_number = '０９０１２３４５６７８'
        @purchase_shipping_adress.valid?
        expect(@purchase_shipping_adress.errors.full_messages).to include("Phone number is invalid")
      end
      it '電話番号は、10桁以上11桁以内の半角数値のみ保存可能なこと（良い例：09012345678 良くない例：abcdefghi）。' do
        @purchase_shipping_adress.phone_number = 'abcdefghij'
        @purchase_shipping_adress.valid?
        expect(@purchase_shipping_adress.errors.full_messages).to include("Phone number is invalid")
      end
      it '電話番号は、10桁以上11桁以内の半角数値のみ保存可能なこと（良い例：09012345678 良くない例：ABCDEFGHI）。' do
        @purchase_shipping_adress.phone_number = 'ABCDEFGHIJ'
        @purchase_shipping_adress.valid?
        expect(@purchase_shipping_adress.errors.full_messages).to include("Phone number is invalid")
      end
      it '電話番号は、10桁以上11桁以内の半角数値のみ保存可能なこと（良い例：09012345678 良くない例：ABCDEFGHI）。' do
        @purchase_shipping_adress.phone_number = 'ｱｲｳｴｵｶｷｸｹｺ'
        @purchase_shipping_adress.valid?
        expect(@purchase_shipping_adress.errors.full_messages).to include("Phone number is invalid")
      end
      it '電話番号は、10桁以上11桁以内の半角数値のみ保存可能なこと（良い例：09012345678 良くない例：アイウエオカキクケコ）。' do
        @purchase_shipping_adress.phone_number = 'アイウエオカキクケコ'
        @purchase_shipping_adress.valid?
        expect(@purchase_shipping_adress.errors.full_messages).to include("Phone number is invalid")
      end
      it '電話番号は、10桁以上11桁以内の半角数値のみ保存可能なこと（良い例：09012345678 良くない例：あいうえおかきくけこ）。' do
        @purchase_shipping_adress.phone_number = 'あいうえおかきくけこ'
        @purchase_shipping_adress.valid?
        expect(@purchase_shipping_adress.errors.full_messages).to include("Phone number is invalid")
      end
      it '電話番号は、10桁以上11桁以内の半角数値のみ保存可能なこと（良い例：09012345678 良くない例：零一二三四五六七八九）。' do
        @purchase_shipping_adress.phone_number = '零一二三四五六七八九'
        @purchase_shipping_adress.valid?
        expect(@purchase_shipping_adress.errors.full_messages).to include("Phone number is invalid")
      end
    end
  end
end