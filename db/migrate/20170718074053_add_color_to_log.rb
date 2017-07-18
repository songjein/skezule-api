class AddColorToLog < ActiveRecord::Migration[5.0]
  def change
    add_column :logs, :color, :string
  end
end
