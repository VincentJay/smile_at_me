class Smile < ActiveRecord::Base

	belongs_to :user
	has_many :relationships, foreign_key: "favored_id", dependent: :destroy
	has_many :favorers, through: :relationships, source: :favorer 
	default_scope -> { order('created_at DESC') }
	validates :image, presence: true
	validates :user_id, presence: true

	

	def self.from_smiles_favored_by(user)
      favored_smile_ids = "SELECT favored_id FROM relationships
                         WHERE favorer_id = :user_id"
      where("smile_id IN (#{favored_smile_ids}) OR user_id = :user_id",
          user_id: user.id)
    end
end
