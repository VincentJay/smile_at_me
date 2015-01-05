class User < ActiveRecord::Base
	has_many :smiles, dependent: :destroy
	has_many :relationships, foreign_key: "favorer_id", dependent: :destroy
	has_many :favored_smiles, through: :relationships, source: :favored


	before_save {self.email = email.downcase}
	before_create :create_remember_token
	validates :name, presence: true, length: {maximum: 50}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

	validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
	has_secure_password
	validates :password, length: {minimum: 6}

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.hash(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

    def feed
      Smile.from_smiles_favored_by(self)
    end
    
    def favoring?(smile)
	  relationships.find_by(favored_id: smile.id)
	end

	  def favor!(smile)
	  	relationships.create!(favored_id: smile.id)
	  end

	  def unfavor!(smile)
	  	relationships.find_by(favored_id: smile.id).destroy
	  end


	private

	  def create_remember_token
	  	self.remember_token = User.hash(User.new_remember_token)
	  end



end
