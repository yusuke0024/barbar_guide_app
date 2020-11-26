require "rails_helper"

RSpec.describe "User", type: :system do

  context "ユーザー名入力フォームが空白のとき" do
    let(:name) { "" }

    it "ユーザー登録に失敗すること" do
      fill_in "user_name", with: name
      fill_in "user_email", with: "example@mail.com"
      fill_in "user_password", with: "foobar"
      click_on "投稿"

      expect(page).to have_content "Content can't be blank"
    end
  end
end
