require "rails_helper"

RSpec.describe "Review", type: :system do
  describe "レビュー新規投稿機能" do
    let(:user) { FactoryBot.create(:user) }
    let(:salon) { FactoryBot.create(:salon) }

    before do
      valid_login(user)
      valid_show(salon)
      click_on "レビューする"
    end

    context "コメントが入力されているとき" do
      let(:comment) { "リラックスできて最高だった" }

      it "正常に投稿されること" do
        expect {
          fill_in "review_comment", with: comment
          click_on "投稿"
        }.to change(Review, :count).by(1)

        expect(current_path).to eq salon_path(salon)
        expect(page).to have_content "yusukeさん : リラックスできて最高だった"
      end
    end

    context "コメントが入力されてないとき" do
      let(:comment) { "" }

      it "投稿に失敗する事" do
        fill_in "review_comment", with: comment
        click_on "投稿"

        expect(page).to have_content "コメントを入力してください"
      end
    end
  end
end
