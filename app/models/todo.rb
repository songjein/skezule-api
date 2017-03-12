class Todo < ApplicationRecord
	belongs_to :log, optional: true
end
