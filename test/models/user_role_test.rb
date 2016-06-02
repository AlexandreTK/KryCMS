require "test_helper"

class UserRoleTest < ActiveSupport::TestCase
  def user_role
    @user_role ||= UserRole.new
  end

  def test_valid
    assert user_role.valid?
  end
end
