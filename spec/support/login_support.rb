module LoginSupport
  def valid_login(user)
    visit salons_path
    click_link "ログインする"
    fill_in "email", with: user.email
    fill_in "password", with: user.password
    click_button "ログインする"
  end
end
