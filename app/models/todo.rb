class Todo < ApplicationRecord
	belongs_to :user
	
	has_many :complete_todos

	acts_as_taggable_on :tags
end
