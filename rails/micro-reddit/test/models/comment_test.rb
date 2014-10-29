require 'test_helper'

class CommentTest < ActiveSupport::TestCase
	def setup
		@comment = Comment.new(body: "Comment No.1", post_id: 1, user_id: 1)
	end

	test "should be valid" do
		assert @comment.valid?
	end

	#Tests for body
	test "body should be present" do
		@comment.body = ""
		assert_not @comment.valid?
	end

	test "body should not be too short" do
		@comment.body = "a" * 4
		assert_not @comment.valid?
	end

	test "body should not be too long" do
		@comment.body = "a" * 256
		assert_not @comment.valid?
	end

	#Test for post_id
	test "post_id should be present" do
		@comment.post_id = nil
		assert_not @comment.valid?
	end

	#Test for user_id
	test "user_id should be present" do
		@comment.user_id = nil
		assert_not @comment.valid?
	end
end
