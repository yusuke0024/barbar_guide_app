require "rails_helper"

RSpec.describe "User", type: :system do

  context "ユーザー名入力フォームが空白のとき" do
    let(:name) { "" }

    it "ユーザー登録に失敗すること" do
      visit new_user_path
      fill_in "user_name", with: name
      fill_in "user_email", with: "example@mail.com"
      fill_in "user_password", with: "foobar"
      click_on "登録"

      expect(page).to have_content "Name can't be blank"
    end
  end
  
  context "ユーザー名が５０文字以上の時" do
    let(:name) { "じゅげむじゅげむごこうのすりきれかいじゃりすいぎょのすいぎょうまつうんらいまつふうらいまつくうねるところにすむところやぶらこうじのぶらこうじ" }

    it "ユーザー登録に失敗すること" do
      visit new_user_path
      fill_in "user_name", with: name
      fill_in "user_email", with: "example@mail.com"
      fill_in "user_password", with: "foobar"
      click_on "登録"

      expect(page).to have_content "Name is too long (maximum is 50 characters)"
    end
  end
end
