class Log < ApplicationRecord
	has_many :complete_todos

	belongs_to :user
end
