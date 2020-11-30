class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.text :comment
      t.bigint :salon_id
      t.bigint :user_id
      
      t.timestamps
    end
  end
end
