module Admin::UserRolesHelper

  def roles_available_select ur

      options_for_select(
        UserRole::DEFAULT_ROLES,
        ur.role_num
      )

  end

  def users_available_select ur
#    begin 
	
      users = User.all

      options_for_select( users.map{ |user| ["#{user.email}", user.id] },
      ur.user_id
      )

  end

  def available_users user_roles
    users = []
    user_roles.each do |ur|
      if !users.include? ur.user_id
        users << ur.user_id
      end
    end
    users.sort! { |a,b| user_email_from_id(a) <=> user_email_from_id(b) }
    users
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

  def user_email_from_id id
    user = User.where(id: id).first
    if(user.blank?)
      "No User"
    else
      user.email
    end
  end


  def roles_from_user_id id
    r_roles = []
    roles = UserRole.where(user_id: id)
    roles.each do |r|
      r_roles << r
    end
    r_roles
  end
