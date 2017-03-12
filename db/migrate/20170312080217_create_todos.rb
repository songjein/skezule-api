class CreateTodos < ActiveRecord::Migration[5.0]
  def change
    create_table :todos do |t|
      t.string :goal
      t.datetime :from
      t.datetime :to
      t.boolean :isCompleted

      t.timestamps
    end
  end
end
