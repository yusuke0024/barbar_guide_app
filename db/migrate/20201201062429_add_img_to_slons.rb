class AddImgToSlons < ActiveRecord::Migration[5.2]
  def change
    add_column :salons, :img, :string, after: :address
  end
end
