class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable


    # format
    # admin/controller
	def has_permission_controller? controller
		if self.admin?
			return true
		end
	    UserRole.where(user_id: self.id).each do |u_r|
	        u_r_actions = u_r.role.allowed_actions
	        u_r_actions.each do |action|
	            if( action.controller.sub('::','/').sub('Controller','').downcase == controller)
	                return true
	            end
	        end
	    end
	    return false
	end


	def is_privileged? 
		if self.admin?
			return true
		end
		roles = UserRole.where(user_id: self.id)
		if !(roles.empty?)
			return true
		end
		return false
	end


end
