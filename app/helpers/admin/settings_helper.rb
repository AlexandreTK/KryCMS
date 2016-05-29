module Admin::SettingsHelper
  def homepage_options
    begin
      grouped_options_for_select({
        "Pages" => Page.all.map { |page| [ page.title, url_for_page(page) ] },
        "Categories" => Category.all.map { |category| [ category.name, category_path(category) ] }
        }, Setting.where(key: "homepage").first.value)
    rescue
      Page.create! title: "Demo page", body: "Hello!", slug: "demo"
      Setting.create! key: "homepage", value: "/demo"
      Setting.create! key: "theme", value: "default"

      grouped_options_for_select({
        "Pages" => Page.all.map { |page| [ page.title, url_for_page(page) ] },
        "Categories" => Category.all.map { |category| [ category.name, category_path(category) ] }
        }, Setting.where(key: "homepage").first.value)

    end
  end

  def theme_options
    begin    
      options_for_select(
        @themes.map { |theme| [ "#{theme.name} (by #{theme.author})", theme.id ] },
        Setting.where(key: "theme").first.value
      )
    rescue
      Page.create! title: "Demo page", body: "Hello!", slug: "demo"
      Setting.create! key: "homepage", value: "/demo"
      Setting.create! key: "theme", value: "default"

      options_for_select(
        @themes.map { |theme| [ "#{theme.name} (by #{theme.author})", theme.id ] },
        Setting.where(key: "theme").first.value
      )
    end     
  end
end
