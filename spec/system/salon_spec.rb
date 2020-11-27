require "rails_helper"
RSpec.describe "Salon", type: :system do

  context "サロン名入力フォームが空白のとき" do
    let(:name) { "" }

    it "サロン登録に失敗すること" do
      visit new_salon_path
      fill_in "salon_name", with: name
      fill_in "salon_address", with: "東京都千代田区丸の内1-8-1"
      click_on "登録"

      expect(page).to have_content "サロン名を入力してください"
    end
  end
end
