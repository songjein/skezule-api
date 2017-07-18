class CreateCompleteTodos < ActiveRecord::Migration[5.0]
  def change
    create_table :complete_todos do |t|
      t.references :todo, foreign_key: true
      t.references :log, foreign_key: true

      t.timestamps
    end
  end
end
