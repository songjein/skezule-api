class RemoveWeightFromTodo < ActiveRecord::Migration[5.0]
  def change
    remove_column :todos, :weight, :integer
  end
end
