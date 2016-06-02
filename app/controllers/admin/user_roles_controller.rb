module Admin

  class UserRolesController < AdminController

    def index
      @user_roles = UserRole.all
    end

    def new
      @user_role =  UserRole.new
    end

    def edit
      @user_role = UserRole.find params[:id]
    end

    def create
        @user_role = UserRole.new user_params
        if @user_role.save
          redirect_to admin_user_roles_path, notice: "Role created."
        else
          render :new
        end
    end

    def update
        @user_role = UserRole.find params[:id]
        if @user_role.update_attributes user_params
          redirect_to admin_user_roles_path, notice: "Role updated."
        else
          render :edit
        end
    end

    def destroy
        @user_role = UserRole.find params[:id]
        if @user_role.destroy
          redirect_to admin_user_roles_path, notice: "Role deleted."
        else
          redirect_to admin_user_roles_path, alert: "Role was not deleted."
        end
    end

    protected

    def user_params
      params.require(:user_role).permit(:user_id, :role_num)
    end

  end

end

