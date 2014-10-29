class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments

	validates :title, presence: true, length: { in: 5..35 },
				uniqueness: true
	validates :user_id, presence: true
end
