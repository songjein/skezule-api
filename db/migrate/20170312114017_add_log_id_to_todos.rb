class AddLogIdToTodos < ActiveRecord::Migration[5.0]
  def change
    add_reference :todos, :log, foreign_key: true
  end
end
