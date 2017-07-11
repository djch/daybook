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
    user = users(:brienne)
    user.reset_token = User.new_token
    mail = UserMailer.password_reset(user)
    assert_equal "Day Book password reset", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match user.name, mail.body.encoded
    assert_match user.reset_token, mail.body.encoded
    assert_match CGI.escape(user.email), mail.body.encoded
  end
end
