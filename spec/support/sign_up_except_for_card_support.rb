module SignUpExceptForCardSupport
  def sign_up_except_for_card(user_built, shipping_address_built)
    visit root_path
    click_on('新規登録')

    fill_in "nickname", with: user_built.nickname
    fill_in "email", with: user_built.email
    fill_in "password", with: user_built.password
    fill_in "password-confirmation", with: user_built.password_confirmation
    fill_in "last-name", with: user_built.last_name
    fill_in "first-name", with: user_built.first_name
    fill_in "last-name-kana", with: user_built.last_name_kana
    fill_in "first-name-kana", with: user_built.first_name_kana
    find("#user_birth_date_1i").find("option[value='#{user_built.birth_date.year}']").select_option
    find("#user_birth_date_2i").find("option[value='#{user_built.birth_date.month}']").select_option
    find("#user_birth_date_3i").find("option[value='#{user_built.birth_date.day}']").select_option
    click_on('Next')

    fill_in "postal-code", with: shipping_address_built.postal_code
    find("#prefecture").find("option[value='#{shipping_address_built.prefecture_id}']").select_option
    fill_in "city", with: shipping_address_built.city
    fill_in "addresses", with: shipping_address_built.address
    fill_in "building", with: shipping_address_built.building_name
    fill_in "phone-number", with: shipping_address_built.phone_number
    click_on('Next')

    expect{
      click_on('登録')
      sleep(2)
    }.to change{User.count}.by(1).and change {ShippingAddress.count}.by(1).and change {Card.count}.by(1)
    expect(current_path).to eq(root_path)
  end
end
