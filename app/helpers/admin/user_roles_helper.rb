module Admin::UserRolesHelper

  def roles_available ur

      options_for_select(
        UserRole::DEFAULT_ROLES,
        ur.role_num
      )

  end

  def users_available ur
#    begin 
	
      users = User.all

      options_for_select( users.map{ |user| ["#{user.email}", user.id] },
      ur.user_id
      )

  end

  def user_email ur
  	user = User.where(id: ur.user_id).first
  	if(user.blank?)
  		"No User"
  	else
  		user.email
  	end
  end

  def role_name r_num
    UserRole::DEFAULT_ROLES.each do |role|
      if role[1] == r_num
        return role[0]
      end
    end
    return "Not found"
  end

end
