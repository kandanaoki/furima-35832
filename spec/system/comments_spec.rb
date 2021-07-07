require 'rails_helper'

RSpec.describe "Comments", type: :system do
  before do
    @user_created = FactoryBot.create(:user)
    @item_created = FactoryBot.create(:item, user_id: @user_created.id)
    @comment = FactoryBot.build(:comment, user_id: @user_created.id, item_id: @item_created.id)
  end

  describe 'コメント機能' do
    context 'コメント機能の正常系' do
      it '条件を満たすとコメントできること' do
        sign_in(@user_created)

        visit item_path(@item_created.id)
        fill_in 'comment_text', with: @comment.text
        expect{
          find('input[name=commit2]').click
          sleep(1)
        }.to change{Comment.count}.by(1)
        expect(page).to have_content(@comment.text)
      end

      it '空でもコメントできること' do
        sign_in(@user_created)

        visit item_path(@item_created.id)
        fill_in 'comment_text', with: ""
        expect{
          find('input[name=commit2]').click
          sleep(1)
        }.to change{Comment.count}.by(1)
        expect(page).to have_content("Commennted by あなた")
      end
      
    end

    context 'コメント機能の異常系' do
      it 'ログインしていないとコメントできないこと' do
        visit root_path
        visit item_path(@item_created.id)
        expect(page).not_to have_content("コメントする")
      end
    end
  end
end
