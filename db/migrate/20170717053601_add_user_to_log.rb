class AddUserToLog < ActiveRecord::Migration[5.0]
  def change
    add_reference :logs, :user, foreign_key: true
  end
end
