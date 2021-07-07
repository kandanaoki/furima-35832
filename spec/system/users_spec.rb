require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    @user_built = FactoryBot.build(:user)
    @user_created = FactoryBot.create(:user)
    @shipping_address_built = FactoryBot.build(:shipping_address)
  end
  
  describe 'ユーザー登録機能' do
    context 'ユーザー登録機能の正常系' do
      it '必要な情報を入力すると登録できること' do
        sign_up(@user_built, @shipping_address_built)
      end

      it 'クレジットカード入力をしなくても登録できてしまうこと' do
        sign_up_except_for_card(@user_built, @shipping_address_built)
      end
    end

    context 'ユーザー登録機能の異常系' do
      it '必要な情報がないと登録できないこと' do
        visit root_path
        click_on('新規登録')

        fill_in "nickname", with: @user_built.nickname
        fill_in "email", with: @user_built.email
        fill_in "password", with: @user_built.password
        fill_in "password-confirmation", with: @user_built.password_confirmation
        fill_in "last-name", with: @user_built.last_name
        fill_in "first-name", with: @user_built.first_name
        fill_in "last-name-kana", with: @user_built.last_name_kana
        fill_in "first-name-kana", with: @user_built.first_name_kana
        find("#user_birth_date_1i").find("option[value='#{@user_built.birth_date.year}']").select_option
        find("#user_birth_date_2i").find("option[value='#{@user_built.birth_date.month}']").select_option
        find("#user_birth_date_3i").find("option[value='#{@user_built.birth_date.day}']").select_option
        click_on('Next')

        find("#prefecture").find("option[value='#{@shipping_address_built.prefecture_id}']").select_option
        fill_in "city", with: @shipping_address_built.city
        fill_in "addresses", with: @shipping_address_built.address
        fill_in "building", with: @shipping_address_built.building_name
        fill_in "phone-number", with: @shipping_address_built.phone_number
        click_on('Next')
        expect(page).to have_content("郵便番号を入力してください")
        expect(page).to have_content("郵便番号は不正な値です")

      end

    end
  end
  describe 'ユーザーログイン機能' do
    context 'ユーザーログイン機能の正常系' do
      it '必要な情報を入力するとログインできること' do
        sign_in(@user_created)
      end
      it 'ログイン後ログアウトできること' do
        sign_in(@user_created)
        sign_out
      end
    end

    context 'ユーザーログイン機能の異常系' do
      it '必要な情報を入力しないとログインできないこと' do
        visit root_path
        click_on('ログイン')
        click_on('ログイン')
        expect(body).to have_content("Eメールまたはパスワードが違います。")
      end
    end
  end

  describe 'マイページ機能' do
    context 'マイページ機能の正常系' do
      it '条件を満たすとマイページを編集できること' do
        sign_up(@user_built, @shipping_address_built)
        click_on(@user_built.nickname)

        fill_in "nickname", with: "変更しました"
        fill_in "password", with: @user_built.password
        fill_in "password-confirmation", with: @user_built.password_confirmation
        click_on('変更')

        expect(page).to have_content("変更しました")
      end
    end

    context 'マイページ機能の異常系' do
      it 'カードを入力しないとマイページに行けないこと' do
        sign_up_except_for_card(@user_built, @shipping_address_built)
        click_on(@user_built.nickname)
        binding.pry
        expect(current_path).to eq(new_card_users_path)
      end

      it '必要な情報を入力しないとマイページを編集できないこと' do
        sign_up(@user_built, @shipping_address_built)
        click_on(@user_built.nickname)

        click_on('変更')
        expect(page).to have_content("パスワードを入力してください")
        expect(page).to have_content("パスワードは不正な値です")
      end
    end
  end
end
