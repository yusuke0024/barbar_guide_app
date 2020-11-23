class RenameAdlessColumnToSalons < ActiveRecord::Migration[5.2]
  def change
    rename_column :salons, :adless, :address
  end
end
