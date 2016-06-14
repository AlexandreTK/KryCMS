module Admin
  class PagesController < AdminController
    before_action :set_page, only: [:show, :edit, :update, :destroy]

    # GET /pages
    # GET /pages.json
    def index
      @pages = Page.all
    end

    # GET /pages/1
    # GET /pages/1.json
    def show
    end

    # GET /pages/new
    def new
      #@page = Page.new type: Type.where(name: params[:type]).first
      @page = Page.new type: Type.where(id: params[:type_id]).first
      if(@page.type != nil)
        @page.type.field_definitions.each do |definition|
          @page.fields.build field_definition: definition
        end
      end
    end

    # GET /pages/1/edit
    def edit
      # If type becomes nil
      if(@page.type == nil)
          @page.fields.each do |p|
            p.destroy
          end
          page_id = @page.id
          @page.save
          @page = Page.find(page_id)
      else

        change = false
        # If type not null (has fields) but was updated
        if(@page.fields.count != 0)
          @page.fields.each do |f|
            if (f.field_definition.type != @page.type)
              change = true
              break
            end
          end
          if(change)
            @page.fields.each do |p|
              p.destroy
            end
            page_id = @page.id
            @page.save
            @page = Page.find(page_id)
          end
        end
        if(change || @page.fields.count == 0)
          @page.type.field_definitions.each do |definition|
            @page.fields.build field_definition: definition
          end
        end
      end
    end

    # POST /pages
    # POST /pages.json
    def create
      @page = Page.new(page_params)

      respond_to do |format|
        if @page.save
          Rails.application.reload_routes!
          format.html { redirect_to admin_page_path(@page), notice: 'Page was successfully created.' }
          format.json { render :show, status: :created, location: @page }
        else
          format.html { render :new }
          format.json { render json: @page.errors, status: :unprocessable_entity }
        end
      end
      # log
      fields = @page.fields.each do |f| f.inspect end
      register_log "Page created: #{@page.inspect} -- Custom type fields: #{fields}\n"
    end

    # PATCH/PUT /pages/1
    # PATCH/PUT /pages/1.json
    def update
      respond_to do |format|
        if @page.update(page_params)
          Rails.application.reload_routes!
          format.html { redirect_to admin_page_path(@page), notice: 'Page was successfully updated.' }
          format.json { render :show, status: :ok, location: @page }
        else
          format.html { render :edit }
          format.json { render json: @page.errors, status: :unprocessable_entity }
        end
      end
      # log
      fields = @page.fields.each do |f| f.inspect end
      register_log "Page updated: #{@page.inspect} -- Custom type fields: #{fields}\n"
    end

    # DELETE /pages/1
    # DELETE /pages/1.json
    def destroy
      # Trying to delete a page that is homepage
      if(Setting.where(key: "homepage").first.value == "/pages/" + @page.id.to_s)
        redirect_to admin_settings_path, alert: "You are trying to delete a page that is Homepage. 
        Please change the settings first."
      else
        # var for register_log
        fields = @page.fields.each do |f| f.inspect end

        @page.destroy
        respond_to do |format|
          format.html { redirect_to admin_pages_url, notice: 'Page was successfully destroyed.' }
          format.json { head :no_content }
        end
        # log
        register_log "Page destroyed: #{@page.inspect} -- Custom type fields: #{fields}\n"
      end
    end

    def update_fields 
      type = Type.where(id: params[:type_id]).first
      @page = Page.where(id: params[:page]).first
      @page.type = type

      #remove unnecessary fields
      @page = clean_page_fields @page

      #update other parameters:
      @page.title = params[:title]
      @page.body = params[:body]
      @page.slug = params[:slug]
      @page.category_id = params[:category_id]


      #puts page.title
      #@page = Page.build type, page
      #puts @page.type
      #render "_form.html.haml", :layout => false
      respond_to do |format|
        format.js { }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_page
        @page = Page.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def page_params
        params.require(:page).permit(:type_id, :title, :body, :slug, :category_id, fields_attributes: [ :field_definition_id, :id, :value] )
      end

      def clean_page_fields page
        if(page.type == nil)
            page.fields.each do |p|
              p.destroy
            end
            page_id = page.id
            page.save
            page = Page.find(page_id)
        else

          change = false
          # If type not null (has fields) but was updated
          if(page.fields.count != 0)
            page.fields.each do |f|
              if (f.field_definition.type != page.type)
                change = true
                break
              end
            end
            if(change)
              page.fields.each do |p|
                p.destroy
              end
              page_id = page.id
              page.save
              page = Page.find(page_id)
            end
          end
          if(change || page.fields.count == 0)
            page.type.field_definitions.each do |definition|
              page.fields.build field_definition: definition
            end
          end
          page.save
          page
        end
      end
  end
end
