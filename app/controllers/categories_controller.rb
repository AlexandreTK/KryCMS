class CategoriesController < ContentController
  def show
    begin
      @category = Category.includes(:pages).find params[:id]
      render template: "category"
    rescue
      redirect_to welcome_path
    end
  end

  protected

  def template_to_render
    if template_exists?("category-#{@category.id}")
      "category-#{@category.id}"
    else
      "category"
    end
  end
end
