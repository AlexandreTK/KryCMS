module Admin::SettingsHelper
  def homepage_options
#    begin
      if Setting.where(key: "homepage").count == 0
        Page.create! title: "Demo page", body: "Hello!", slug: "demo"
        Setting.create! key: "homepage", value: "/demo"
      end

      page_options = []
      page_options << Setting::DEFAULT_HOMEPAGE
      Page.all.each { |page| page_options << [ page.title, url_for_page(page) ] }

      grouped_options_for_select({
        "Pages" => page_options,
        "Categories" => Category.all.map { |category| [ category.name, category_path(category) ] }
        }, Setting.where(key: "homepage").first.value)
  end

  def theme_options
#    begin 
      if Setting.where(key: "theme").count == 0
        Setting.create! key: "theme", value: "default"
      end

      options_for_select(
        @themes.map { |theme| [ "#{theme.name} (by #{theme.author})", theme.id ] },
        Setting.where(key: "theme").first.value
      )
  end
end
