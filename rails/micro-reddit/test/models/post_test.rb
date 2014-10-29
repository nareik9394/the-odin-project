require 'test_helper'

class PostTest < ActiveSupport::TestCase
	def setup
		@post = Post.new(title: "First Post", body: "Body of First Post",
							url: "www.google.com", user_id: 1)
	end

	test "should be valid" do
		assert @post.valid?
	end

	#Test for title
	test "title should be present" do
		@post.title = ""
		assert_not @post.valid?
	end

	test "title should not be too short" do
		@post.title = "a" * 4
		assert_not @post.valid?
	end

	test "title should not be too long" do
		@post.title = "a" * 36
		assert_not @post.valid?
	end

	test "title should be unique" do
		duplicate_post = @post.dup
		duplicate_post.title = @post.title
		@post.save
		assert_not duplicate_post.valid?
	end

	#Test for author_id
	test "author_id should be present" do
		@post.author_id = nil
		assert_not @post.valid?
	end
end
