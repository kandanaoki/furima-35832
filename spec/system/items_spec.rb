require 'rails_helper'

RSpec.describe 'Items', type: :system do
  before do
    @item = FactoryBot.build(:item)
    @user_built = FactoryBot.build(:user)
    @user_created = FactoryBot.create(:user)
  end
  describe '商品出品機能' do
      

    context '商品出品機能の正常系' do
      it 'ログイン状態の場合のみ、商品出品ページへ遷移できること。' do
        sign_in(@user_created)
        visit new_item_path
      end

      it 'カテゴリーは、「---、メンズ、レディース、ベビー・キッズ、インテリア・住まい・小物、本・音楽・ゲーム、おもちゃ・ホビー・グッズ、家電・スマホ・カメラ、スポーツ・レジャー、ハンドメイド、その他」の11項目が表示されること（--- は初期値として設定すること）。' do
        sign_in(@user_created)
        visit new_item_path
        expect(page).to have_select('item-category', options: [
          '---', 'メンズ', 'レディース', 'ベビー・キッズ', 'インテリア・住まい・小物', '本・音楽・ゲーム', 'おもちゃ・ホビー・グッズ', '家電・スマホ・カメラ', 'スポーツ・レジャー', 'ハンドメイド', 'その他'
          ])
      end

      it '商品の状態は、「---、新品・未使用、未使用に近い、目立った傷や汚れなし、やや傷や汚れあり、傷や汚れあり、全体的に状態が悪い」の7項目が表示されること（--- は初期値として設定すること）。' do
        sign_in(@user_created)
        visit new_item_path
        expect(page).to have_select('item-sales-status', options: [
          '---', '新品・未使用', '未使用に近い', '目立った傷や汚れなし', 'やや傷や汚れあり', '傷や汚れあり', '全体的に状態が悪い'
          ])
      end

      it '配送料の負担は、「---、着払い(購入者負担)、送料込み(出品者負担)」の3項目が表示されること（--- は初期値として設定すること）。' do
        sign_in(@user_created)
        visit new_item_path
        expect(page).to have_select('item-shipping-fee-status', options: [
          '---', '着払い(購入者負担)', '送料込み(出費者負担)'
          ])
      end

      it '発送元の地域は、「---」と47都道府県の合計48項目が表示されること（--- は初期値として設定すること）。' do
        sign_in(@user_created)
        visit new_item_path
        expect(page).to have_select('item-prefecture', options: [
          '---' , '北海道' , '青森県' , '岩手県' , '宮城県' , '秋田県' , '山形県' , '福島県' , '茨城県' , '栃木県' , '群馬県' , '埼玉県' , '千葉県' , '東京都' , '神奈川県' , '新潟県' , '富山県' , '石川県' , '福井県' , '山梨県' , '長野県' , '岐阜県' , '静岡県' , '愛知県' , '三重県' , '滋賀県' , '京都府' , '大阪府' , '兵庫県' , '奈良県' , '和歌山県' , '鳥取県' , '島根県' , '岡山県' , '広島県' , '山口県' , '徳島県' , '香川県' , '愛媛県' , '高知県' , '福岡県' , '佐賀県' , '長崎県' , '熊本県' , '大分県' , '宮崎県' , '鹿児島県' , '沖縄県'
          ])
      end

      it '発送までの日数は、「---、1~2日で発送、2~3日で発送、4~7日で発送」の4項目が表示されること（--- は初期値として設定すること）。' do
        sign_in(@user_created)
        visit new_item_path
        expect(page).to have_select('item-scheduled-delivery', options: [
          '---', '1~2日間で発送', '2~3日間で発送', '4~7日間で発送'
          ])
      end

      it '必要な情報を適切に入力して「出品する」ボタンを押すと、商品情報がデータベースに保存されること。' do
        sign_in(@user_created)
        visit new_item_path
        image_path = Rails.root.join('public/images/test_image.png')
        attach_file('item[image]', image_path, make_visible: true)
        fill_in 'item-name', with: @item.name
        fill_in 'item-info', with: @item.description
        find("#item-category").find("option[value='#{@item.category_id}']").select_option
        find("#item-sales-status").find("option[value='#{@item.status_id}']").select_option
        find("#item-shipping-fee-status").find("option[value='#{@item.shipping_charge_id}']").select_option
        find("#item-prefecture").find("option[value='#{@item.prefecture_id}']").select_option
        find("#item-scheduled-delivery").find("option[value='#{@item.days_to_ship_id}']").select_option
        fill_in 'item-price', with: @item.price
        expect{find('input[name="commit"]').click}.to change{Item.count}.by(1)
      end
      it '入力された価格によって、販売手数料や販売利益の表示が変わること。' do
        sign_in(@user_created)
        visit new_item_path
        @item.price = 300
        fill_in 'item-price', with: @item.price
        tax_before = find("#add-tax-price").text.to_i
        profit_before = find("#add-tax-price").text.to_i
        @item.price = 9999999
        fill_in 'item-price', with: @item.price
        tax_after = find("#add-tax-price").text.to_i
        profit_after = find("#profit").text.to_i
        expect(tax_before).not_to eq tax_after
        expect(profit_before).not_to eq profit_after
      end
    end
    
    context '商品出品機能の正常系' do
      it 'ログアウト状態の場合は、商品出品ページへ遷移しようとすると、ログインページへ遷移すること。' do
        visit new_item_path
        expect(current_path).to eq new_user_session_path
      end
      it 'エラーハンドリングができること（入力に問題がある状態で「出品する」ボタンが押された場合、情報は保存されず、出品ページに戻りエラーメッセージが表示されること）。' do
        sign_in(@user_created)
        visit new_item_path
        expect{find('input[name="commit"]').click}.to change{Item.count}.by(0)
        # 出品ページに戻ること
        expect(current_path).to eq items_path
        # 以下エラーメッセージ
        expect(page).to have_content("Name can't be blank")
        expect(page).to have_content("Description can't be blank")
        expect(page).to have_content("Category must be other than 1")
        expect(page).to have_content("Status must be other than 1")
        expect(page).to have_content("Shipping charge must be other than 1")
        expect(page).to have_content("Prefecture must be other than 1")
        expect(page).to have_content("Days to ship must be other than 1")
        expect(page).to have_content("Image can't be blank")
        expect(page).to have_content("Image can't be blank")
        expect(page).to have_content("Image can't be blank")
        expect(page).to have_content("Price is not a number")
      end

      it 'エラーハンドリングによって出品ページに戻った場合でも、入力済みの項目（商品画像・販売手数料・販売利益以外）は消えないこと。' do
        sign_in(@user_created)
        visit new_item_path
        fill_in 'item-name', with: @item.name
        fill_in 'item-info', with: @item.description
        find("#item-category").find("option[value='#{@item.category_id}']").select_option
        find("#item-sales-status").find("option[value='#{@item.status_id}']").select_option
        find("#item-shipping-fee-status").find("option[value='#{@item.shipping_charge_id}']").select_option
        find("#item-prefecture").find("option[value='#{@item.prefecture_id}']").select_option
        find("#item-scheduled-delivery").find("option[value='#{@item.days_to_ship_id}']").select_option
        expect{find('input[name="commit"]').click}.to change{Item.count}.by(0)
        expect(current_path).to eq items_path
        
        expect(page).to have_field('item-name', with: @item.name)
        expect(page).to have_field('item-info', with: @item.description)
        expect(page).to have_field('item-category', with: @item.category_id, visible: false)
        expect(page).to have_field('item-sales-status', with: @item.status_id, visible: false)
        expect(page).to have_field('item-shipping-fee-status', with: @item.shipping_charge_id, visible: false)
        expect(page).to have_field('item-prefecture', with: @item.prefecture_id, visible: false)
        expect(page).to have_field('item-scheduled-delivery', with: @item.days_to_ship_id, visible: false)
      end
    end
  end
end

# - 
# - 
# - 
# - 
# - 
# - 
# - 
# -   
# - 
# - 
# - 
# - 
# - 
# - 
# - 
# - 
# - 
# - 
# - 
# - 
# - 
# - 