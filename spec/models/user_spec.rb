require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録' do
    context '保存できる場合' do
      it '必須条件が満たされていれば登録できること' do
        expect(@user).to be_valid
      end
    end
    
    context '保存できない場合' do
      it 'ニックネームが必須であること。' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
  
      it 'メールアドレスが必須であること。' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
  
      it 'メールアドレスが一意性であること。' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
  
      it 'メールアドレスは、@を含む必要があること。' do
        @user.email = 'aaaaaaaaaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
  
      it 'パスワードが必須であること。' do
        @user.password = ''
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
  
      it 'パスワードは、6文字以上での入力が必須であること' do
        @user.password = 'five5'
        @user.password_confirmation = 'five5'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
  
      it 'パスワードは、半角英数字混合での入力が必須であること(アルファベットが無いVer)' do
        @user.password = '666666'
        @user.password_confirmation = '666666'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
  
      it 'パスワードは、半角英数字混合での入力が必須であること(数字が無いVer)' do
        @user.password = 'sixsix'
        @user.password_confirmation = 'sixsix'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end

      it 'パスワードは、半角英数字混合での入力が必須であること(全角Ver)' do
        @user.password = 'SIXSIX６６６'
        @user.password_confirmation = 'sixsix'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
  
      it 'パスワードとパスワード（確認）は、値の一致が必須であること。' do
        @user.password = 'six666'
        @user.password_confirmation = '666six'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
  
      it 'お名前(全角)は、名字と名前がそれぞれ必須であること。(名字がないVer)' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
  
      it 'お名前(全角)は、名字と名前がそれぞれ必須であること。(名前がないver)' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
  
      it 'お名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること。(名字が半角Ver)' do
        @user.last_name = 'ﾊﾝｶｸ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid')
      end
  
      it 'お名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること。(名前が半角ver)' do
        @user.first_name = 'ﾊﾝｶｸ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end
  
      it 'お名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること。(名字がALPHABET ver)' do
        # お名前は、全角（漢字・ひらがな・カタカナ）であること
        @user.last_name = 'ALPHABET'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid')
      end
  
      it 'お名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること。(名前がALPHABET ver)' do
        # お名前は、全角（漢字・ひらがな・カタカナ）であること
        @user.first_name = 'ALPHABET'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end
  
      it 'お名前カナ(全角)は、名字と名前がそれぞれ必須であること。(名字がないver)' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
  
      it 'お名前カナ(全角)は、名字と名前がそれぞれ必須であること。(名前がないver)' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
  
      it 'お名前カナ(全角)は、全角（カタカナ）での入力が必須であること。(名字が半角ver)' do
        # 全角であること
        @user.last_name_kana = 'ﾊﾝｶｸ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid')
      end
  
      it 'お名前カナ(全角)は、全角（カタカナ）での入力が必須であること。(名前が半角ver)' do
        # 全角であること
        @user.first_name_kana = 'ﾊﾝｶｸ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid')
      end
  
      it 'お名前カナ(全角)は、全角（カタカナ）での入力が必須であること。(名字がALPHABET ver)' do
        # カタカナであること
        @user.last_name_kana = 'ALPHABET'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid')
      end

      it 'お名前カナ(全角)は、全角（カタカナ）での入力が必須であること。(名前がALPHABET ver)' do
        # カタカナであること
        @user.first_name_kana = 'ALPHABET'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid')
      end

      it '生年月日が必須であること。' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end

    end
  end
end
