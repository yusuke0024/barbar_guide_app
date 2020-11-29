require "rails_helper"

RSpec.feature "Login", type: :system do
  let(:user) { FactoryBot.create(:user) }

  context "有効な情報を入力したとき" do
    it "ユーザーはログインに成功すること" do
      #有効なデータでログイン
      valid_login(user)
      expect(current_path).to eq salons_path
      expect(page).to have_content "ログインしました"
      expect(page).to have_content "サロン一覧表示"
    end
  end

  context "無効な情報を入力したとき" do
    it "ユーザーはログインに失敗すること" do
      visit salons_path
      click_on "ログインする", match: :first
      fill_in "email", with: ""
      fill_in "password", with: ""
      click_button "ログインする"

      expect(page).to have_content "ログインする"
      expect(page).to have_content "IDかパスワードが間違っているか、会員ではありません。"
    end
  end
end
