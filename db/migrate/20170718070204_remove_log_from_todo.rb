class RemoveLogFromTodo < ActiveRecord::Migration[5.0]
  def change
    remove_reference :todos, :log, foreign_key: true
  end
end
