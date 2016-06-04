class AdminController < ApplicationController
 
  before_filter :authenticate_user!
  before_filter :ensure_admin


private
def ensure_admin
  unless current_user && current_user.admin?
    #render :text => "You are not authorised to perform this action", :status => :unauthorized
    reset_session
  	redirect_to user_session
  end
end

def register_log message
	CustomLog.debug(current_user.id.to_s + "_" + current_user.name, message)
end


end
