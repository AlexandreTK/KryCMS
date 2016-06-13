class RoleAction < ActiveRecord::Base
	belongs_to :role
	belongs_to :allowed_action
end
