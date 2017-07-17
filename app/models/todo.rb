class Todo < ApplicationRecord
	belongs_to :user
	belongs_to :log, optional: true

	acts_as_taggable_on :tags
end
