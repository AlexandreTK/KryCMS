require "test_helper"

class RoleTest < ActiveSupport::TestCase
  def role
    @role ||= Role.new
  end

  def test_valid
    assert role.valid?
  end
end
