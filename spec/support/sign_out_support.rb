module SignOutSupport
  def sign_out
    visit root_path
    click_on('ログアウト')
    expect(body).to have_content('ログイン')
  end
end
