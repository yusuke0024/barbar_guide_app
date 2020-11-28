require "rails_helper"

RSpec.describe "User", type: :system do
  describe "ユーザー登録機能" do
    let(:user) { FactoryBot.create(:user) }

    before do
      visit new_user_path
    end

    context "ユーザー名入力フォームが空白のとき" do
      let(:name) { "" }

      it "エラーになること" do
        fill_in "user_name", with: name
        fill_in "user_email", with: user.email
        fill_in "user_password", with: user.password
        click_on "登録"

        expect(page).to have_content "ユーザー名を入力してください"
      end
    end

    context "ユーザー名が５０文字以上のとき" do
      let(:name) { "じゅげむじゅげむごこうのすりきれかいじゃりすいぎょのすいぎょうまつうんらいまつふうらいまつくうねるところにすむところやぶらこうじのぶらこうじ" }

      it "エラーになること" do
        fill_in "user_name", with: name
        fill_in "user_email", with: user.email
        fill_in "user_password", with: user.password
        click_on "登録"

        expect(page).to have_content "ユーザー名は50文字以内で入力してください"
      end
    end

    context "メールアドレスが空白のとき" do
      let(:email) { "" }

      it "エラーになること" do
        fill_in "user_name", with: user.name
        fill_in "user_email", with: email
        fill_in "user_password", with: user.password
        click_on "登録"

        expect(page).to have_content "メールアドレスを入力してください"
      end
    end

    context "メールアドレスが一意でないとき" do
      let(:dup_email) { user.email.upcase }

      it "エラーになること" do
        fill_in "user_name", with: user.name
        fill_in "user_email", with: user.email
        fill_in "user_password", with: user.password
        click_on "登録"
        visit new_user_path
        fill_in "user_name", with: user.name
        fill_in "user_email", with: dup_email
        fill_in "user_password", with: user.password
        click_on "登録"

        expect(page).to have_content "メールアドレスはすでに存在します"
      end
    end

    context "メールアドレスが256文字以上のとき" do
      let(:email) { "a" * 247 + "@mail.com" }

      it "エラーになること" do
        fill_in "user_name", with: user.name
        fill_in "user_email", with: email
        fill_in "user_password", with: user.password
        click_on "登録"

        expect(page).to have_content "メールアドレスは255文字以内で入力してください"
      end
    end

    context "メールアドレスのフォーマットが不正なとき" do
      let(:email) { "hoge@mail" }

      it "エラーになること" do
        fill_in "user_name", with: user.name
        fill_in "user_email", with: email
        fill_in "user_password", with: user.password
        click_on "登録"

        expect(page).to have_content "メールアドレスは不正な値です"
      end
    end
  end
end
