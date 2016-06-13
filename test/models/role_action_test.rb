require "test_helper"

class RoleActionTest < ActiveSupport::TestCase
  def role_action
    @role_action ||= RoleAction.new
  end

  def test_valid
    assert role_action.valid?
  end
end
