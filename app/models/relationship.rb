class Relationship < ActiveRecord::Base
	default_scope -> { order('created_at DESC') }
	belongs_to :favorer, class_name: "User"
	belongs_to :favored, class_name: "Smile"
	validates :favorer_id, presence: true
    validates :favored_id, presence: true
end
