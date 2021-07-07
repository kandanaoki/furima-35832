require 'rails_helper'

RSpec.describe ItemTag, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @shipping_address = FactoryBot.build(:shipping_address, user_id: @user.id)
  end
  describe '住所登録機能' do
    context '住所登録機能の正常系' do
      it '必要な情報を入力すると住所登録できること' do
        expect(@shipping_address).to be_valid
      end
      it 'building_nameがなくても住所登録できること' do
        @shipping_address.building_name = ''
        expect(@shipping_address).to be_valid
      end

      it 'user_idがなくても住所登録できること' do
        @shipping_address.user_id = ''
        expect(@shipping_address).to be_valid
      end
    end

    context '商品出荷機能の異常系' do
      it 'cityを入力しないと住所登録できないこと' do
        @shipping_address.city = ''
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("市区町村を入力してください")
      end

      it 'addressを入力しないと住所登録できないこと' do
        @shipping_address.address = ''
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("番地を入力してください")
      end

      it 'postal_codeを入力しないと住所登録できないこと' do
        @shipping_address.postal_code = ''
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("郵便番号を入力してください")
      end
      it 'postal_codeが数字でないと住所登録できないこと(小文字alphabet Ver)' do
        @shipping_address.postal_code = 'abc-defg'
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("郵便番号は不正な値です")
      end
      it 'postal_codeが数字でないと住所登録できないこと(大文字alphabet Ver)' do
        @shipping_address.postal_code = 'ABC-DEFG'
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("郵便番号は不正な値です")
      end
      it 'postal_codeが数字でないと住所登録できないこと(ひらがな Ver)' do
        @shipping_address.postal_code = 'あいう-えおかき'
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("郵便番号は不正な値です")
      end
      it 'postal_codeが数字でないと住所登録できないこと(半角カタカタ Ver)' do
        @shipping_address.postal_code = 'ｱｲｳ-ｴｵｶｷ'
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("郵便番号は不正な値です")
      end
      it 'postal_codeが数字でないと住所登録できないこと(全角カタカタ Ver)' do
        @shipping_address.postal_code = 'アイウ-エオカキ'
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("郵便番号は不正な値です")
      end
      it 'postal_codeが数字でないと住所登録できないこと(漢字 Ver)' do
        @shipping_address.postal_code = '一二三-四五六七'
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("郵便番号は不正な値です")
      end
      it '「-」がないと住所登録できないこと' do
        @shipping_address.postal_code = '1234567'
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("郵便番号は不正な値です")
      end

      it '3文字と4文字に別れていないと住所登録できないこと' do
        @shipping_address.postal_code = '1234-567'
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("郵便番号は不正な値です")
      end

      it 'prefecture_idを入力しないと住所登録できないこと' do
        @shipping_address.prefecture_id = ''
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("都道府県を入力してください")
      end
      it 'prefecture_idが1だと住所登録できないこと' do
        @shipping_address.prefecture_id = 1
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("都道府県は1以外の値にしてください")
      end
      
      it 'phone_numberを入力しないと住所登録できないこと' do
        @shipping_address.phone_number = ''
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("電話番号を入力してください")
      end
      it 'phone_numberが数字でないと住所登録できないこと(小文字alphabet Ver)' do
        @shipping_address.phone_number = 'abcdefghij'
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("電話番号は不正な値です")
      end
      it 'phone_numberが数字でないと住所登録できないこと(大文字alphabet Ver)' do
        @shipping_address.phone_number = 'ABCDEFGHIJ'
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("電話番号は不正な値です")
      end
      it 'phone_numberが数字でないと住所登録できないこと(ひらがな Ver)' do
        @shipping_address.phone_number = 'あいうえおかきくけこ'
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("電話番号は不正な値です")
      end
      it 'phone_numberが数字でないと住所登録できないこと(半角カタカタ Ver)' do
        @shipping_address.phone_number = 'ｱｲｳｴｵｶｷｸｹｺ'
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("電話番号は不正な値です")
      end
      it 'phone_numberが数字でないと住所登録できないこと(全角カタカタ Ver)' do
        @shipping_address.phone_number = 'アイウエオカキクケコ'
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("電話番号は不正な値です")
      end
      it 'phone_numberが数字でないと住所登録できないこと(漢字 Ver)' do
        @shipping_address.phone_number = '一二三四五六七八九十'
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("電話番号は不正な値です")
      end
      it '9文字以下だと住所登録できないこと' do
        @shipping_address.phone_number = '123456789'
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("電話番号は不正な値です")
      end
      it '12文字以上だと住所登録できないこと' do
        @shipping_address.phone_number = '123456789012'
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("電話番号は不正な値です")
      end

    end
  end
end
