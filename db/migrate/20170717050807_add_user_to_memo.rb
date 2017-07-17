class AddUserToMemo < ActiveRecord::Migration[5.0]
  def change
    add_reference :memos, :user, foreign_key: true
  end
end
