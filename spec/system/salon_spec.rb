require "rails_helper"
RSpec.describe "Salon", type: :system do

  describe "サロン登録ページ表示機能" do

    context "ユーザーが管理者のとき" do
      let(:user) { FactoryBot.create(:user, role: 1) }

      it "サロン登録ページが表示されること" do
        valid_login(user)
        visit new_salon_path

        expect(page).to have_content "サロン新規登録"
      end
    end

    context "ユーザーが管理者ではないとき" do
      let(:user) { FactoryBot.create(:user, role: 0) }

      it "サロン登録ページが表示されないこと" do
        valid_login(user)
        visit new_salon_path

        expect(page).to have_content "管理者ではありません"
      end
    end

  end

  describe "サロン新規登録機能" do

    before do
      visit new_salon_path
      fill_in "salon_name", with: "THE BAR BAR"
      fill_in "salon_address", with: "東京都千代田区丸の内1-8-1"
    end

    context "サロン名が20文字以内で住所が150文字以内で入力されているとき" do
      it "正常に登録されること" do
        expect {
          click_on "登録"
        }.to change(Salon, :count).by(1)

        expect(current_path).to eq new_salon_path
      end
    end

    context "サロン名入力フォームが空白のとき" do
      let(:name) { "" }

      it "エラーになること" do
        fill_in "salon_name", with: name
        click_on "登録"

        expect(page).to have_content "サロン名を入力してください"
      end
    end

    context "サロン名が21文字以上のとき" do
      let(:name) { "宇宙で一番名前が長いのでどんな名前やねんそれ、ほんまにヘアサロンか？とツッコミがくるお店" }

      it "エラーになること" do
        fill_in "salon_name", with: name
        click_on "登録"

        expect(page).to have_content "サロン名は20文字以内で入力してください"
      end
    end

    context "住所入力フォームが空白のとき" do
      let(:address) { "" }

      it "エラーになること" do
        fill_in "salon_address", with: address
        click_on "登録"

        expect(page).to have_content "住所を入力してください"
      end
    end

    context "住所が151文字以上のとき" do
      let(:address) { "東京" * 100 }

      it "エラーになること" do
        fill_in "salon_address", with: address
        click_on "登録"

        expect(page).to have_content "住所は150文字以内で入力してください"
      end
    end
  end
end
