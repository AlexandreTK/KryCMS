class AdminController < ApplicationController

  before_filter :authenticate_user!
  before_filter :ensure_permission



private
def register_log message
	CustomLog.debug(current_user.id.to_s + "_" + current_user.name, message)
end

def ensure_admin
  unless current_user && current_user.admin?
    #render :text => "You are not authorised to perform this action", :status => :unauthorized
    reset_session
  	redirect_to user_session
  end
end


def ensure_permission
  if !(current_user)
    return false
  end
  if current_user.admin?
    return true
  end

  UserRole.where(user_id: current_user.id).each do |u_r|

      u_r_actions = u_r.role.allowed_actions
      u_r_actions.each do |action|

        if( action.controller.sub('::','/').sub('Controller','').downcase == params[:controller].to_s && action.action == action_name)
          return true
        end
      end
  end
  redirect_to user_session
  reset_session
end



end
