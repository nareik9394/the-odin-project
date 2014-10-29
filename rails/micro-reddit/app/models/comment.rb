class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :post

	validates :body, presence: true, length: { in: 5..255 }
	validates :post_id, presence: true
	validates :user_id, presence: true
end
