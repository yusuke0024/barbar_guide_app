class AddIndexReviewSalonid < ActiveRecord::Migration[5.2]
  def change
    add_index :reviews, [:salon_id, :user_id]
  end
end
