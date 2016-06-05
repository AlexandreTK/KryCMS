class PagesController < ContentController
  def show
    begin
      @page = Page.find params[:id]
      render template: template_to_render
    rescue
      redirect_to welcome_path
    end
  end

  protected


  def template_to_render
    if template_exists?("page-#{@page.id}")
      "page-#{@page.id}"
    else
      if @page.type != nil
        if template_exists?("page-#{@page.type.name}")
          "page-#{@page.type.name}"
        else
          "page"
        end
      end
      "page"
    end
  end

end
