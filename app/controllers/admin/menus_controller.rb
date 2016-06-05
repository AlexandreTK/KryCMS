module Admin
  class MenusController < AdminController
    def index
      @menus = Menu.all
    end

    def new
      @menu = Menu.new
      #params[:parent_id]
      m = @menu.menu_items.build 
      2.times {m.children.build}
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
      # Before build 8 additional fields
      @menu = Menu.find params[:id]
      #8.times { @menu.menu_items.build }

  
      # Now: build only x additional fields, where x + blank fields = 6
      # @menu = Menu.find params[:id]
      # additional = 6
      # @menu.menu_items.each do |mi| 
      #   if (mi.title.blank? && mi.url.blank? && additional > 0)
      #     additional = additional - 1
      #   end
      # end
      # additional.times { @menu.menu_items.build }
    end

    def destroy
      @menu = Menu.find params[:id]
      
      #var for register_log
      # menu_items = @menu.menu_items.each do |m| m.inspect end
 
      if @menu.destroy
        redirect_to admin_menus_path, notice: "Menu deleted."
      else
        redirect_to admin_menus_path, alert: "Menu was not deleted."
      end
      # register_log "Menu destroyed: #{@menu.inspect} -- Menu Items: #{menu_items}\n"
    end

    protected

    def menu_params
      params.require(:menu).permit(:name, :menu_items_attributes => [ :id, :title, :url, :_destroy, :children_attributes =>[:id, :title, :url, :_destroy, :parent_id, :children]] )
    end
  end
end
