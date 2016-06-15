module Admin
  class RolesController < AdminController

    # Maybe
    # before_filter :ensure_admin
    
    before_action :set_role, only: [:edit, :update, :destroy]

    # TESTING BUILD_CONTROLLERS
    #before_action :build_controllers, only:[:index]
    
    # GET /roles
    # GET /roles.json
    def index
      @roles = Role.all
    end

    # GET /roles/new
    def new
      @role = Role.new
    end

    # GET /roles/1/edit
    def edit
    end

    # POST /roles
    # POST /roles.json
    def create
      @role = Role.new(role_params)

      respond_to do |format|
        if @role.save
          format.html { redirect_to admin_roles_path, notice: 'Role was successfully created.' }
          format.json { render :show, status: :created, location: @role }
        else
          format.html { render :new }
          format.json { render json: @role.errors, status: :unprocessable_entity }
        end
      end
      register_log "Role created: #{@role.inspect}\n"
    end

    # PATCH/PUT /roles/1
    # PATCH/PUT /roles/1.json
    def update
      respond_to do |format|
        if @role.update(role_params)
          format.html { redirect_to admin_roles_path, notice: 'Role was successfully updated.' }
          format.json { render :show, status: :ok, location: @role }
        else
          format.html { render :edit }
          format.json { render json: @role.errors, status: :unprocessable_entity }
        end
      end
      register_log "Role updated: #{@role.inspect}\n"
    end

    # DELETE /roles/1
    # DELETE /roles/1.json
    def destroy
      @role.destroy
      respond_to do |format| 
        format.html { redirect_to admin_roles_path, notice: 'Role was successfully destroyed.' }
        format.json { head :no_content }
      end
      register_log "Role destroyed: #{@role.inspect}\n"
    end



    def build_controllers
      AllowedAction.destroy_all
      ApplicationController.descendants.each do |c|
        if (c.to_s.start_with?"Admin::")
          c.action_methods.each do |a|
            AllowedAction.create!(controller: c.to_s, action: a.to_s)
          end
        end
      end
      redirect_to admin_roles_path
      register_log "Updating application controllers \n"
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_role
        @role = Role.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def role_params
        params.require(:role).permit(:title, :allowed_action_ids => [])
      end


  end
end