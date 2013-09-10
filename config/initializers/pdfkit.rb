# config/initializers/pdfkit.rb
ActionController::Base.asset_host = Proc.new { |source, request|
  if request.format.pdf?
    "#{request.protocol}#{request.host_with_port}"
  else
    nil
  end
}

PDFKit.configure do |config|     
	if RUBY_PLATFORM = ~/linux/
		wkhtmltopdf_executable = 'wkhtmltopdf-amd64'
		config.wkhtmltopdf = Rails.root.join('vendor', 'wkhtmltopdf-amd64').to_s
	# else
		# wkhtmltopdf_executable = 'wkhtmltopdf'
		# config.wkhtmltopdf = Rails.root.join('vendor', 'wkhtmltopdf-amd64').to_s
	end
 # config.wkhtmltopdf = Rails.root.join('vendor', 'wkhtmltopdf-amd64').to_s #if RAILS_ENV == 'production'
  config.default_options = {
    page_size: 'A4',
    print_media_type: true,
    orientation: 'Landscape'
    }
  config.root_url = "file://#(Rails.root.join('public'))/" #if RAILS_ENV == 'production'
end

