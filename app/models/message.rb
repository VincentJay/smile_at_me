class Message < ActiveRecord::Base
	default_scope -> { order('created_at DESC') }
	belongs_to :sender, class_name: 'User'
	belongs_to :receiver, class_name: 'User'
	validates :sender_id, presence: true
    validates :receiver_id, presence: true
end
