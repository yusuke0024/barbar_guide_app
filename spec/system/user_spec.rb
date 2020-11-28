require "rails_helper"

RSpec.describe "User", type: :system do
  describe "ユーザー登録機能" do

    before do
      #新規ユーザー登録ページ
      visit new_user_path
      #正常範囲の入力値を入力
      fill_in "user_name", with: "yusuke"
      fill_in "user_email", with: "example@mail.com"
      fill_in "user_password", with: "foobar"
    end

    context "ユーザー名５０文字以内、メールアドレス不正ではないフォーマット、パスワード６文字以上のとき" do
      it "正常に登録されること" do
        expect {
          click_on "登録"
        }.to change(User, :count).by(1)

        expect(current_path).to eq salons_path
      end
    end

    context "ユーザー名入力フォームが空白のとき" do
      let(:name) { "" }

      it "エラーになること" do
        fill_in "user_name", with: name
        click_on "登録"

        expect(page).to have_content "ユーザー名を入力してください"
      end
    end

    context "ユーザー名が５０文字以上のとき" do
      let(:name) { "じゅげむじゅげむごこうのすりきれかいじゃりすいぎょのすいぎょうまつうんらいまつふうらいまつくうねるところにすむところやぶらこうじのぶらこうじ" }

      it "エラーになること" do
        fill_in "user_name", with: name
        click_on "登録"

        expect(page).to have_content "ユーザー名は50文字以内で入力してください"
      end
    end

    context "メールアドレスが空白のとき" do
      let(:email) { "" }

      it "エラーになること" do
        fill_in "user_email", with: email
        click_on "登録"

        expect(page).to have_content "メールアドレスを入力してください"
      end
    end

    context "メールアドレスが一意でないとき" do
      let(:email) { "example1@mail.com" }

      it "エラーになること" do
        fill_in "user_email", with: email
        click_on "登録"
        visit new_user_path
        fill_in "user_email", with: email
        click_on "登録"

        expect(page).to have_content "メールアドレスはすでに存在します"
      end
    end

    context "メールアドレスが256文字以上のとき" do
      let(:email) { "a" * 247 + "@mail.com" }

      it "エラーになること" do
        fill_in "user_email", with: email
        click_on "登録"

        expect(page).to have_content "メールアドレスは255文字以内で入力してください"
      end
    end

    context "メールアドレスのフォーマットが不正なとき" do
      let(:email) { "hoge@mail" }

      it "エラーになること" do
        fill_in "user_email", with: email
        click_on "登録"

        expect(page).to have_content "メールアドレスは不正な値です"
      end
    end

    context "パスワードが空白のとき" do
      let(:password) { "" }

      it "エラーになること" do
        fill_in "user_password", with: password
        click_on "登録"

        expect(page).to have_content "パスワードを入力してください"
        expect(page).to_not have_content "パスワードは6文字以上で入力してください"
      end
    end

    context "パスワードが5文字以下のとき" do
      let(:password) { "penta" }

      it "エラーになること" do
        fill_in "user_password", with: password
        click_on "登録"

        expect(page).to have_content "パスワードは6文字以上で入力してください"
      end
    end
  end
end
