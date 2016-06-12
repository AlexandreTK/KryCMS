class AdminController < ApplicationController

  before_filter :authenticate_user!
#  before_filter :ensure_admin
  before_filter :ensure_privileged


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

# General privilege
def ensure_privileged
  unless current_user && current_user.is_privileged?
    reset_session
  	redirect_to user_session
  end
end

# Full Manager
def ensure_full_manager
  unless current_user && current_user.is_full_manager?
    reset_session
  	redirect_to user_session
  end
end

# Content Manager
def ensure_content_manager
  unless current_user && current_user.is_content_manager?
    reset_session
  	redirect_to user_session
  end
end
# Product Manager
def ensure_product_manager
  unless current_user && current_user.is_product_manager?
    reset_session
  	redirect_to user_session
  end
end


end
