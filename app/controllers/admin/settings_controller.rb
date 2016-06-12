module Admin
  class SettingsController < AdminController

    before_filter :ensure_admin

    def index
      @settings = Setting.all
      @themes = get_themes

      # @controllers = get_controllers
    end


    def update
      setting_params.each do |key, value|
        Setting.where(key: key).first.update_attribute :value, value
      end
      Rails.application.reload_routes!
      redirect_to admin_settings_path, notice: "Settings saved."
      register_log "Settings updated\n"
    end


    private

    def setting_params
      params.require(:settings).permit(:homepage, :theme)
    end

    def get_themes
      themes_directory = File.join(Rails.root, "app/themes/")
      theme_folders = Dir.entries(themes_directory).select do |item|
        !%w(. ..).include?(item)
      end.map do |folder|
        OpenStruct.new((YAML.load_file File.join(themes_directory, folder, "info.yaml")).merge id: folder)
      end
    end


    # def get_controllers
    #   controllers = Hash.new("Controllers-Actions")
    #   #controller = []
    #   ApplicationController.descendants.each do |c|
    #     actions = []
    #     # c.constantize.action_methods ....
    #     c.action_methods.collect{|a| actions << a.to_s}
    #     controllers["#{c}"] = actions
    #   end
    #   controllers
    # end

  end
end