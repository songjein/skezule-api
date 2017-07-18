class CompleteTodo < ApplicationRecord
  belongs_to :todo
  belongs_to :log
end
