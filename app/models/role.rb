class Role < ActiveRecord::Base
	has_many :role_actions, dependent: :destroy
	has_many :allowed_actions, through: :role_actions
end
