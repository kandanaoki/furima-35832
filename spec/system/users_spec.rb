require 'rails_helper'

RSpec.describe 'Users', type: :system do
  before do
    @user_created = FactoryBot.create(:user)
    @user_built = FactoryBot.build(:user)
  end

  describe '新規登録' do
    context '新規登録の正常系' do
      it 'トップページ（商品一覧ページ）ヘッダーの、「新規登録」ボタンをクリックすると、各ページに遷移できること。' do
        visit root_path
        click_on('新規登録')
        expect(current_path).to eq new_user_registration_path
      end

      it '必要な情報を適切に入力して「会員登録」ボタンを押すと、ユーザーの新規登録ができること。' do
        visit new_user_registration_path
        fill_in 'nickname', with: @user_built.nickname
        fill_in 'email', with: @user_built.email
        fill_in 'password', with: @user_built.password
        fill_in 'password-confirmation', with: @user_built.password_confirmation
        fill_in 'last-name', with: @user_built.last_name
        fill_in 'first-name', with: @user_built.first_name
        fill_in 'last-name-kana', with: @user_built.last_name_kana
        fill_in 'first-name-kana', with: @user_built.first_name_kana
        select @user_built.birth_date.year, from: 'user[birth_date(1i)]'
        select @user_built.birth_date.month, from: 'user[birth_date(2i)]'
        select @user_built.birth_date.day, from: 'user[birth_date(3i)]'
        expect { find('input[name="commit"]').click }.to change { User.count }.by(1)
      end
    end

    context '新規登録の異常系' do
      it '新規登録にエラーハンドリングができること（入力に問題がある状態で「会員登録」ボタンが押された場合、情報は受け入れられず、各ページでエラーメッセージが表示されること）。' do
        visit new_user_registration_path
        fill_in 'password-confirmation', with: @user_built.password_confirmation
        expect { find('input[name="commit"]').click }.to change { User.count }.by(0)
        expect(page).to have_content("Email can't be blank")
        expect(page).to have_content("Password can't be blank")
        expect(page).to have_content('Password is invalid')
        expect(page).to have_content("Password confirmation doesn't match Password")
        expect(page).to have_content("Nickname can't be blank")
        expect(page).to have_content("First name can't be blank")
        expect(page).to have_content('First name is invalid')
        expect(page).to have_content("Last name can't be blank")
        expect(page).to have_content('Last name is invalid')
        expect(page).to have_content("First name kana can't be blank")
        expect(page).to have_content('First name kana is invalid')
        expect(page).to have_content("Last name kana can't be blank")
        expect(page).to have_content('Last name kana is invalid')
        expect(page).to have_content("Birth date can't be blank")
      end

      it 'エラーハンドリングによって新規登録/ログインページに戻った場合でも、入力済みの項目（パスワード・パスワード確認用以外）は消えないこと。' do
        visit new_user_registration_path
        fill_in 'nickname', with: @user_built.nickname
        fill_in 'email', with: @user_built.email
        fill_in 'last-name', with: @user_built.last_name
        fill_in 'first-name', with: @user_built.first_name
        fill_in 'last-name-kana', with: @user_built.last_name_kana
        fill_in 'first-name-kana', with: @user_built.first_name_kana
        select @user_built.birth_date.year, from: 'user[birth_date(1i)]'
        select @user_built.birth_date.month, from: 'user[birth_date(2i)]'
        select @user_built.birth_date.day, from: 'user[birth_date(3i)]'
        expect { find('input[name="commit"]').click }.to change { User.count }.by(0)
        expect(page).to have_field('nickname', with: @user_built.nickname)
        expect(page).to have_field('email', with: @user_built.email)
        expect(page).to have_field('password', with: '')
        expect(page).to have_field('password-confirmation', with: '')
        expect(page).to have_field('last-name', with: @user_built.last_name)
        expect(page).to have_field('first-name', with: @user_built.first_name)
        expect(page).to have_field('last-name-kana', with: @user_built.last_name_kana)
        expect(page).to have_field('first-name-kana', with: @user_built.first_name_kana)
      end
    end

    context 'ログイン正常系' do
      it 'トップページ（商品一覧ページ）ヘッダーの、「ログイン」ボタンをクリックすると、各ページに遷移できること。' do
        visit root_path
        click_on('ログイン')
        expect(current_path).to eq new_user_session_path
      end

      it '必要な情報を適切に入力して「ログイン」ボタンを押すと、ユーザーのログインができること。' do
        sign_in(@user_created)
      end

      it 'トップページ（商品一覧ページ）ヘッダーの、「ログアウト」ボタンをクリックすると、ログアウトができること ' do
        sign_in(@user_created)
        click_on('ログアウト')
        expect(current_path).to eq root_path
        expect(page).to have_content('新規登録')
        expect(page).to have_content('ログイン')
      end
    end
    context 'ログイン異常系' do
      it 'ログインにエラーハンドリングができること（入力に問題がある状態で「ログイン」ボタンが押された場合、情報は受け入れられず、各ページでエラーメッセージが表示されること）。' do
        visit new_user_session_path
        click_on('ログイン')
        expect(current_path).to eq new_user_session_path
        expect(page).to have_content('Invalid Email or password')
      end
    end
  end
end

# - ログアウト状態の場合には、トップページ（商品一覧ページ）のヘッダーに、「新規登録」「ログイン」ボタンが表示されること。
# - ログイン状態の場合には、トップページ（商品一覧ページ）のヘッダーに、「ユーザーのニックネーム」と「ログアウト」ボタンが表示されること。
# - エラーハンドリングの際、重複したエラーメッセージが表示されないこと。
