module ApplicationHelper
  def url_for_page page
    path = if page.slug.present?
      page.slug
    else
      "pages/#{page.id}"
    end

    root_path + path
  end

  def url_for_menu_item menu_item
    if menu_item.url.match /:\/\// # http://, ftp://, etc.
      menu_item.url
    else
      root_path + menu_item.url
    end
  end

def link_to_add_fields(name, f, association)
  new_object = f.object.send(association).klass.new
  id = new_object.object_id
  fields = f.fields_for(association, new_object, child_index: id) do |builder|
    render(association.to_s.singularize + "_fields", f:builder)
  end
  link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
end

end
