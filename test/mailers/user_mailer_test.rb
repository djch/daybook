require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "welcome_aboard" do
    user = users(:brienne)
    mail = UserMailer.welcome_aboard(user)
    assert_equal "A few details about your Day Book account", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match user.name, mail.body.encoded
  end

  test "password_reset" do
    mail = UserMailer.password_reset
    assert_equal "Password reset", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end
end
