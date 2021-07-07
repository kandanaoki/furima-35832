require 'rails_helper'

RSpec.describe "Items", type: :system do
  before do
    @user_created_seller = FactoryBot.create(:user)
    @user_created_consumer = FactoryBot.create(:user)
    @user_built = FactoryBot.build(:user)
    @shipping_address_built = FactoryBot.build(:shipping_address)
    @item_built = FactoryBot.build(:item, user_id: @user_created_seller.id)
    @item_created = FactoryBot.create(:item, user_id: @user_created_seller.id)
    @item_created_purchased = FactoryBot.create(:item, user_id: @user_created_seller.id)
    @tag_built = FactoryBot.build(:tag)
    @tag_created = FactoryBot.create(:tag)
    @item_tag_relation_created = FactoryBot.create(:item_tag_relation, item_id: @item_created.id, tag_id: @tag_created.id)
    @purchase_created = FactoryBot.create(:purchase, user_id: @user_created_consumer.id, item_id: @item_created_purchased.id)
  end

  describe 'アイテム出品機能' do
    context 'アイテム出品機能の正常系' do
      it '必要な情報を入力するとアイテム出品できること' do
        sign_in(@user_created_seller)

        shipping(@item_built, @tag_built)
      end

      it 'タグがなくてもアイテム出品できること' do
        sign_in(@user_created_seller)

        visit new_item_path
        image_path = Rails.root.join('public/images/test_image.png')
        attach_file('item_tag[images][]', image_path, make_visible: true)
        fill_in 'item-name', with: @item_built.name
        fill_in 'item-info', with: @item_built.description
        find("#item-category").find("option[value='#{@item_built.category_id}']").select_option
        find("#item-sales-status").find("option[value='#{@item_built.status_id}']").select_option
        find("#item-shipping-fee-status").find("option[value='#{@item_built.shipping_charge_id}']").select_option
        find("#item-prefecture").find("option[value='#{@item_built.prefecture_id}']").select_option
        find("#item-scheduled-delivery").find("option[value='#{@item_built.days_to_ship_id}']").select_option
        fill_in 'item-price', with: @item_built.price
        expect{click_on('出品する')}.to change{Item.count}.by(1)
        
        expect(page).to have_content(@item_built.name)
      end

    end

    context 'アイテム出品機能の異常系' do
      it 'ログインしていないとアイテム出品ページにいけないこと' do
        visit root_path
        visit new_item_path
        expect(current_path).to eq(new_user_session_path)
      end
      
      it '必要な情報がないとアイテム出品できないこと' do
        sign_in(@user_created_seller)

        visit new_item_path
        image_path = Rails.root.join('public/images/test_image.png')
        attach_file('item_tag[images][]', image_path, make_visible: true)
        fill_in 'item-info', with: @item_built.description
        find("#item-category").find("option[value='#{@item_built.category_id}']").select_option
        find("#item-sales-status").find("option[value='#{@item_built.status_id}']").select_option
        find("#item-shipping-fee-status").find("option[value='#{@item_built.shipping_charge_id}']").select_option
        find("#item-prefecture").find("option[value='#{@item_built.prefecture_id}']").select_option
        find("#item-scheduled-delivery").find("option[value='#{@item_built.days_to_ship_id}']").select_option
        fill_in 'item-price', with: @item_built.price
        expect{click_on('出品する')}.to change{Item.count}.by(0)
        end
    end
  end

  describe 'アイテム編集機能' do
    context 'アイテム編集機能の正常系' do
      it '必要な情報を入力するとアイテム編集できること' do
        sign_in(@user_created_seller)

        visit edit_item_path(@item_created.id)

        image_path = Rails.root.join('public/images/test_image.png')
        attach_file('item_tag[images][]', image_path, make_visible: true)
        fill_in 'item-name', with: "編集しました"
        fill_in 'item-info', with: "編集しました"
        fill_in 'tag-name', with: "編集しました"
        find("#item-category").find("option[value='#{@item_created.category_id}']").select_option
        find("#item-sales-status").find("option[value='#{@item_created.status_id}']").select_option
        find("#item-shipping-fee-status").find("option[value='#{@item_created.shipping_charge_id}']").select_option
        find("#item-prefecture").find("option[value='#{@item_created.prefecture_id}']").select_option
        find("#item-scheduled-delivery").find("option[value='#{@item_created.days_to_ship_id}']").select_option
        fill_in 'item-price', with: @item_created.price
        click_on('変更する')
        
        expect(page).to have_content("編集しました")
      end
    end

    context 'アイテム編集機能の異常系' do
      it 'ログインしていないとアイテム編集ページにいけないこと' do
        visit edit_item_path(@item_created.id)
        expect(current_path).to eq(new_user_session_path)
      end
      
      it '出品者でないとアイテム編集ページにいけないこと' do
        sign_in(@user_created_consumer)
        visit edit_item_path(@item_created.id)
        expect(current_path).to eq(root_path)
      end

      it '購入されているとアイテム編集ページにいけないこと' do
        sign_in(@user_created_seller)
        visit edit_item_path(@item_created_purchased.id)
        expect(current_path).to eq(root_path)
      end

      it '必要な情報が入力されていないと編集できないこと' do
        sign_in(@user_created_seller)

        visit edit_item_path(@item_created.id)

        image_path = Rails.root.join('public/images/test_image.png')
        attach_file('item_tag[images][]', image_path, make_visible: true)
        fill_in 'item-name', with: ""
        fill_in 'item-info', with: "編集しました"
        fill_in 'tag-name', with: "編集しました"
        find("#item-category").find("option[value='#{@item_created.category_id}']").select_option
        find("#item-sales-status").find("option[value='#{@item_created.status_id}']").select_option
        find("#item-shipping-fee-status").find("option[value='#{@item_created.shipping_charge_id}']").select_option
        find("#item-prefecture").find("option[value='#{@item_created.prefecture_id}']").select_option
        find("#item-scheduled-delivery").find("option[value='#{@item_created.days_to_ship_id}']").select_option
        fill_in 'item-price', with: @item_created.price
        click_on('変更する')
        expect(page).to have_content("商品名を入力してください")
      end
    end
  end

  describe 'アイテム削除機能' do
    context 'アイテム削除機能の正常系' do
      it '条件を満たすととアイテム削除できること' do
        sign_in(@user_created_seller)

        visit item_path(@item_created.id)
        expect{click_link '削除'}.to change{Item.count}.by(-1)
      end
    end

    context 'アイテム削除機能の異常系' do
      it 'ログインしていないと削除ボタンが表示されないこと' do
        visit item_path(@item_created.id)
        expect(page).not_to have_link '削除'
      end
      
      it '出品者でないと削除ボタンが表示されないこと' do
        sign_in(@user_created_consumer)
        visit item_path(@item_created.id)
        expect(page).not_to have_link '削除'
      end

      it '購入されていると削除ボタンが表示されないこと' do
        sign_in(@user_created_seller)
        visit edit_item_path(@item_created_purchased.id)
        expect(page).not_to have_link '削除'
      end
    end
  end

  describe 'アイテム購入機能' do
    context 'アイテム購入機能の正常系' do
      it '条件を満たせばアイテムを購入できること' do
        sign_up(@user_built, @shipping_address_built)
        visit item_path(@item_created.id)        
        expect{click_on('購入する')}.to change{Purchase.count}.by(1)
      end
    end

    context 'アイテム購入機能の異常系' do
      it 'カードがなければカード登録画面に遷移すること' do
        sign_up_except_for_card(@user_built, @shipping_address_built)
        visit item_path(@item_created.id)        
        expect{click_on('購入する')}.to change{Purchase.count}.by(0)
        expect(current_path).to eq (new_card_item_path(@item_created.id))
      end
    end
  end
  
  describe '複雑な検索機能' do
    context '複雑な検索機能の正常系' do
      it '条件を満たすアイテムがあれば検索結果があること' do
        visit root_path
        click_on("限定して検索する")
        select @item_created.name, from: 'q_name_eq'
        page.all(".search-button")[1].click
        expect(page).to have_content(@item_created.name)
      end
    end

    context '複雑な検索機能の異常系' do
      it '条件を満たすアイテムがなければ検索結果がないこと' do
        visit root_path
        @item_created.destroy
        @purchase_created.destroy
        @item_created_purchased.destroy
        click_on("限定して検索する")
        page.all(".search-button")[1].click
        expect(page).to have_content("該当する商品はありません")
      end
    end
  end

  describe 'タグ検索機能' do
    context 'タグ検索機能の正常系' do
      it '条件を満たすアイテムがあれば検索結果があること' do
        visit root_path
        fill_in 'input-box', with: @item_tag_relation_created.tag.tag_name
        page.all(".search-button")[0].click
        expect(page).to have_content(@item_tag_relation_created.item.name)
      end
    end

    context 'タグ検索機能の異常系' do
      it '条件を満たすアイテムがなければ検索結果がないこと' do
        visit root_path
        @item_created.destroy
        fill_in 'input-box', with: @tag_created.tag_name
        page.all(".search-button")[0].click
        
        expect(page).to have_content("該当する商品はありません")
      end
    end
  end
end
