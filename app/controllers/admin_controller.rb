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

end


#before_filter :ensure_admin, :only => [:new, :create]
#private
#def ensure_admin
# unless current_user && current_user.admin?
#   render :text => "You are not authorised to perform this action", :status => :unauthorized
# end
#end