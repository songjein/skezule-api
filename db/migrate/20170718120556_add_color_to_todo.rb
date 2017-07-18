class AddColorToTodo < ActiveRecord::Migration[5.0]
  def change
    add_column :todos, :color, :string
  end
end
