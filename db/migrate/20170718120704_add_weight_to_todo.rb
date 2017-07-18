class AddWeightToTodo < ActiveRecord::Migration[5.0]
  def change
    add_column :todos, :weight, :integer
  end
end
