class AllowedAction < ActiveRecord::Base
	has_many :role_actions, dependent: :destroy
	has_many :roles, through: :role_actions
end
