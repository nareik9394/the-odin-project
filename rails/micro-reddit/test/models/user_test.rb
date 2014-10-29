require 'test_helper'

class UserTest < ActiveSupport::TestCase
	def setup
		@user = User.new(user_name: "nareik", email: "user@example.com",
					password: "foobar", password_confirmation: "foobar")
	end

	test "should be valid" do
		assert @user.valid?
	end

	#Tests for user_name
	test "user_name should be present" do
		@user.user_name = ""
		assert_not @user.valid?
	end

	test "user_name should not be too long" do
		@user.user_name = "a" * 26
		assert_not @user.valid?
	end

	test "user_name should be unique" do
	  	duplicate_user = @user.dup
	  	duplicate_user.user_name = @user.user_name
	  	@user.save
	  	assert_not duplicate_user.valid?
	end

	test "user_name should accept valid usernames" do
		valid_user_names = %w[_nareik Incarnati0nEUW xHardSoul Chess_cake
								IM_AN_AUSSIE_AMA 7on7o Sweet-Jesus a]
		valid_user_names.each do |valid_user_name|
			@user.user_name = valid_user_name
			assert @user.valid?, "#{valid_user_name.inspect} should be valid"
		end
	end

	test "user_name should reject invalid usernames" do
		invalid_user_names = %w[$ken_mother nareik@nareik #hash_tag what%areyou
								this\\is\\cool]
		invalid_user_names.each do |invalid_user_name|
			@user.user_name = invalid_user_name
			assert_not @user.valid?, "#{invalid_user_name.inspect} should be invalid"
		end
	end

	#Tests for email
	test "email should be present" do
		@user.email = ""
		assert_not @user.valid?
	end

	test "email should not be too long" do 
		@user.email = "a" * 256
		assert_not @user.valid?
	end

	test "email validation should accept valid addresses" do
	  	valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
	  							first.last@foo.jp alice+bob@baz.cn]
	  	valid_addresses.each do |valid_address|
	  		@user.email = valid_address
	  		assert @user.valid?, "#{valid_address.inspect} should be valid"
	  	end
	end

	test "email validation should reject invalid addresses" do
	  	invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
	                        	foo@bar_baz.com foo@bar+baz.com foo@bar..com]
	    invalid_addresses.each do |invalid_address|
	    	@user.email = invalid_address
	    	assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
	    end
	end

	test "email addresses should be unique" do
	  	duplicate_user = @user.dup
	  	duplicate_user.email = @user.email.upcase
	  	@user.save
	  	assert_not duplicate_user.valid?
	end

	test "email addresses should be saved as lower-case" do
	  	mixed_case_email = "Foo@ExAMPle.CoM"
	  	@user.email = mixed_case_email
	  	@user.save
	  	assert_equal mixed_case_email.downcase, @user.reload.email
	end

	#Tests for password
	test "password should not be too short" do 
		@user.password = @user.password_confirmation = "a" * 5
		assert_not @user.valid?
	end

	test "password should not be too long" do
		@user.password = @user.password_confirmation = "a" * 21
		assert_not @user.valid?
	end
end
