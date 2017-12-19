class UpdateColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :roll, :role
  end
end
