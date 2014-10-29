class User < ActiveRecord::Base
	has_many :posts
	has_many :comments

	before_save { email.downcase! }

	VALID_USER_NAME_REGEX = /\A[\w\d-]+\z/
	validates :user_name, presence: true, length: { maximum: 25 },
				format: { with: VALID_USER_NAME_REGEX },
				uniqueness: true

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
				format: { with: VALID_EMAIL_REGEX },
				uniqueness: { case_sensitive: false }

	has_secure_password
	validates :password, length: { minimum: 6, maximum: 20 }
end
