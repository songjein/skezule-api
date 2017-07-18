class AddStringWeightToTodo < ActiveRecord::Migration[5.0]
  def change
    add_column :todos, :weight, :string
  end
end
