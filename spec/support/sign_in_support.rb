module SignInSupport
  def sign_in(user_created)
    visit new_user_session_path
    fill_in 'email', with: user_created.email
    fill_in 'password', with: user_created.password
    click_on('ログイン')
    expect(current_path).to eq root_path
    expect(page).to have_content(user_created.nickname)
    expect(page).to have_content('ログアウト')
  end
end
