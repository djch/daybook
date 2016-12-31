require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Charles Danielworth", email: "charliedan@fake.org", password: "stkilda1966")
  end

  test "should pass validation" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "  "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "  "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    # Max 50 chars
    @user.name = "dan" * 17
    assert_not @user.valid?
  end

  test "email should not be too long" do
    # Max 255 chars
    @user.email = "sk8rboi" * 35 + "@memail.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[SALLY@foo.com SA-LL_Y@foo.bar.org first.last@foo.jp don+creative@scdp.com]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[SALLY@foo,com betty_francis_at_foo.org first.last@foo. don@sc+dp.com joan@hhp..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert @user.invalid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "cOoLbEaNz@whatEV.COM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present (non-blank)" do
    @user.password = " " * 8
    assert_not @user.valid?
  end

  test "password should be long enough" do
    @user.password = "b1" * 3
    assert_not @user.valid?
  end
end
