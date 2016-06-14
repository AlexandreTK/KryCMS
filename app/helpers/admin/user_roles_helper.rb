module Admin::UserRolesHelper


  def roles_available_select user_role

      options_for_select(
        Role.all.map{|role| ["#{role.title}", role.id]},
        user_role.role_id
      )
  end

  def users_available_select user_role
  
      users = User.all

      options_for_select( users.map{ |user| ["#{user.email}", user.id] },
      user_role.user_id
      )
  end


  def users_from_roles user_roles
    users = []
    user_roles.each do |ur|
      u = User.where(id: ur.user_id).first
      if u!= nil
        if !users.include? u
          users << u
        end
      end
    end
    users.sort! { |a,b| a.email <=> b.email }
    users
  end


  def user_roles_from_user user
    r_roles = []
    user_roles = UserRole.where(user_id: user.id)
    user_roles.each do |r|
      r_roles << r
    end
    r_roles
  end

# NEW 1

  # def user_ids_from_roles user_roles
  #   users = []
  #   user_roles.each do |ur|
  #     if !users.include? ur.user_id
  #       users << ur.user_id
  #     end
  #   end
  #   users.sort! { |a,b| user_email_from_user_id(a) <=> user_email_from_user_id(b) }
  #   users
  # end


  # def user_email_from_user_id id
  #   user = User.where(id: id).first
  #   if(user.blank?)
  #     "No User"
  #   else
  #     user.email
  #   end
  # end


  # def role_title_from_user_role user_role
  #   if user_role == nil
  #     return "Not found"
  #   end
  #   role = Role.where(id: user_role.role_id).first
  #   if role == nil
  #     return "Not found"
  #   end
  #   return role.title
  # end


  # def user_roles_from_user_id id
  #   r_roles = []
  #   roles = UserRole.where(user_id: id)
  #   roles.each do |r|
  #     r_roles << r
  #   end
  #   r_roles
  # end











#OLD

  # def roles_available_select ur

  #     options_for_select(
  #       UserRole::DEFAULT_ROLES,
  #       ur.role_num
  #     )

  # end

  # def users_available_select ur
	
  #     users = User.all

  #     options_for_select( users.map{ |user| ["#{user.email}", user.id] },
  #     ur.user_id
  #     )

  # end

  # def available_users user_roles
  #   users = []
  #   user_roles.each do |ur|
  #     if !users.include? ur.user_id
  #       users << ur.user_id
  #     end
  #   end
  #   users.sort! { |a,b| user_email_from_id(a) <=> user_email_from_id(b) }
  #   users
  # end

  # def user_email ur
  # 	user = User.where(id: ur.user_id).first
  # 	if(user.blank?)
  # 		"No User"
  # 	else
  # 		user.email
  # 	end
  # end

  # def role_name r_num
  #   UserRole::DEFAULT_ROLES.each do |role|
  #     if role[1] == r_num
  #       return role[0]
  #     end
  #   end
  #   return "Not found"
  # end


  # def user_email_from_id id
  #   user = User.where(id: id).first
  #   if(user.blank?)
  #     "No User"
  #   else
  #     user.email
  #   end
  # end


  # def roles_from_user_id id
  #   r_roles = []
  #   roles = UserRole.where(user_id: id)
  #   roles.each do |r|
  #     r_roles << r
  #   end
  #   r_roles
  # end

  
end