module SignInSupport
  def sign_in(user_created)
    visit root_path
    click_on('ログイン')
    fill_in "email", with: user_created.email
    fill_in "password", with: user_created.password
    click_on('ログイン')
    expect(current_path).to eq(root_path)
  end
end
