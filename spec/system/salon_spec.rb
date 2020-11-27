require "rails_helper"
RSpec.describe "Salon", type: :system do
  let(:salon) { FactoryBot.create(:salon) }

  context "サロン名入力フォームが空白のとき" do
    let(:name) { "" }

    it "サロン登録に失敗すること" do
      visit new_salon_path
      fill_in "salon_name", with: name
      fill_in "salon_address", with: salon.address
      click_on "登録"

      expect(page).to have_content "サロン名を入力してください"
    end
  end

  context "サロン名が２０文字以上のとき" do
    let(:name) { "宇宙で一番名前が長いのでどんな名前やねんそれ、ほんまにヘアサロンか？とツッコミがくるお店" }

    it "サロン登録に失敗すること" do
      visit new_salon_path
      fill_in "salon_name", with: name
      fill_in "salon_address", with: salon.address
      click_on "登録"

      expect(page).to have_content "サロン名は20文字以内で入力してください"
    end
  end

  context "住所入力フォームが空白のとき" do
    let(:address) { "" }

    it "サロン登録に失敗すること" do
      visit new_salon_path
      fill_in "salon_name", with: salon.name
      fill_in "salon_address", with: address
      click_on "登録"

      expect(page).to have_content "住所を入力してください"
    end
  end

  context "住所が150文字以上のとき" do
    let(:address) { "東京" * 100 }

    it "サロン登録に失敗すること" do
      visit new_salon_path
      fill_in "salon_name", with: salon.name
      fill_in "salon_address", with: address
      click_on "登録"

      expect(page).to have_content "住所は150文字以内で入力してください"
    end
  end
end
