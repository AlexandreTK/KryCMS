module Admin
  class MenusController < AdminController
    def index
      @menus = Menu.all
    end

    def new
      @menu = Menu.new
      10.times { @menu.menu_items.build }
    end

    def create
      @menu = Menu.new menu_params
      if @menu.save
        redirect_to admin_menus_path, notice: "Menu created."
      else
        render :new
      end
      menu_items = @menu.menu_items.each do |m| m.inspect end
      register_log "Menu created: #{@menu.inspect} -- Menu Items: #{menu_items}\n"
    end

    def update
      @menu = Menu.find params[:id]
      if @menu.update_attributes menu_params
        redirect_to admin_menus_path, notice: "Menu updated."
      else
        render :edit
      end
      menu_items = @menu.menu_items.each do |m| m.inspect end
      register_log "Menu updated: #{@menu.inspect} -- Menu Items: #{menu_items}\n"
    end

    def edit
      @menu = Menu.find params[:id]
      10.times { @menu.menu_items.build }
    end

    def destroy
      @menu = Menu.find params[:id]
      
      #var for register_log
      menu_items = @menu.menu_items.each do |m| m.inspect end
 
      if @menu.destroy
        redirect_to admin_menus_path, notice: "Menu deleted."
      else
        redirect_to admin_menus_path, alert: "Menu was not deleted."
      end
      register_log "Menu destroyed: #{@menu.inspect} -- Menu Items: #{menu_items}\n"
    end

    protected

    def menu_params
      params.require(:menu).permit(:name, :menu_items_attributes => [ :title, :url, :id] )
    end
  end
end
