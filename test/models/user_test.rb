require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup 
  	@user = User.new(name: "defaultuser", email: "defaultemail", 
            password: "foobar", password_confirmation: "foobar")
  end

 test "should be valid" do
    	assert_not @user.valid?
  end

 test "name should be present" do
    	@user.email = "     "
  		assert_not @user.valid?
  end
	
 test "email should be present" do
    @user.email = "        "
    assert_not @user.valid?
  end

 test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.name = "a" * 101
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn wiki.cryhost@pitas.pl wiki@olek.pl]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "sprawdzam unikalnosc loginu" do 
    the_same_name = @user.dup
    the_same_name.email = @user.email.upcase
    @user.save
    assert_not the_same_name.valid?

  end

   test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
    
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 4
    assert_not @user.valid?

  end
end
