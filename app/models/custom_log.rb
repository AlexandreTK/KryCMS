class CustomLog
	def self.debug(author="default", message=nil)
		return unless message.present? and Rails.env.production?
		dir = File.dirname("#{Rails.root}/log/custom_logs/#{Date.today.strftime("%Y-%m")}/#{author}.log")
		FileUtils.mkdir_p(dir) unless File.directory?(dir)
		@logger ||= Logger.new("#{Rails.root}/log/custom_logs/#{Date.today.strftime("%Y-%m")}/#{author}.log")
		@logger.debug(message)

	end
end
