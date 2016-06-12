class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable



	def is_privileged?
		if self.admin?
			return true
		end
		roles = UserRole.where(user_id: self.id)
		roles.each do |r|
			if (r.role_num == UserRole::CONTENT_M || 
				r.role_num == UserRole::PRODUCT_M || 
				r.role_num == UserRole::FULL_M   )
				return true
			end
		end
		return false
	end

	def is_full_manager?
		if self.admin?
			return true
		end
		roles = UserRole.where(user_id: self.id)
		roles.each do |r|
			if (r.role_num == UserRole::FULL_M)
				return true
			end
		end
		return false
	end

	def is_content_manager?
		if self.admin?
			return true
		end
		roles = UserRole.where(user_id: self.id)
		roles.each do |r|
			if (r.role_num == UserRole::CONTENT_M || 
				r.role_num == UserRole::FULL_M)
				return true
			end
		end
		return false
	end

	def is_product_manager?
		if self.admin?
			return true
		end
		roles = UserRole.where(user_id: self.id)
		roles.each do |r|
			if (r.role_num == UserRole::PRODUCT_M || 
				r.role_num == UserRole::FULL_M)
				return true
			end
		end
		return false
	end


end
