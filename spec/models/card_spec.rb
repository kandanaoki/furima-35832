require 'rails_helper'

RSpec.describe Card, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @card = FactoryBot.build(:card, user_id: @user.id)
  end

  describe 'クレジットカートの登録機能' do
    context 'クレジットカードの登録機能の正常系' do
      it '必要な情報を入力すると登録できること' do
        expect(@card).to be_valid
      end

      it 'user_idが空でも登録できること' do
        @card.user_id = ''
        expect(@card).to be_valid
      end
    end

    context 'クレジットカートの登録機能の異常系' do
      it 'customer_tokenが空だと登録できないこと' do
        @card.customer_token = ''
        @card.valid?
        expect(@card.errors.full_messages).to include("Customer tokenを入力してください")
      end
    end
  end
end
