require "rails_helper"

describe "review#user_display_name" do
  it "レビューにに紐づいた表示用の名前を返す" do
    salon = FactoryBot.build(:salon)
    user = FactoryBot.build(:user)
    review = FactoryBot.build(:review, salon: salon, user: user)
    decorated_review = ActiveDecorator::Decorator.instance.decorate(review)

    expect(decorated_review.user_display_name).to eq("yusukeさん")
  end
end
