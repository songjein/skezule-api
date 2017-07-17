class AddMemoToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :memo, :text
  end
end
