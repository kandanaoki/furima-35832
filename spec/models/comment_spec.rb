require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @comment = FactoryBot.build(:comment, user_id: @user.id, item_id: @item.id)
  end
  describe 'コメント機能' do
    context 'コメント機能の正常系' do
      it '必要な情報を入力するとコメントできること' do
        expect(@comment).to be_valid
      end
      it 'textがなくてもできること' do
        @comment.text = ''
        expect(@comment).to be_valid
      end
    end
  end
end
