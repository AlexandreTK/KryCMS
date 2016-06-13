require "test_helper"

class AllowedActionTest < ActiveSupport::TestCase
  def allowed_action
    @allowed_action ||= AllowedAction.new
  end

  def test_valid
    assert allowed_action.valid?
  end
end
