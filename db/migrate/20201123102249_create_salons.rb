class CreateSalons < ActiveRecord::Migration[5.2]
  def change
    create_table :salons do |t|
      t.string :name
      t.string :adless

      t.timestamps
    end
  end
end
