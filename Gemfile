source 'https://rubygems.org'

ruby '1.9.3'

gem 'rails', '3.2.14'
gem 'bootstrap-sass', '2.1'
gem 'jquery-rails', '2.0.2'
gem 'pg', '0.15.1'                        # database connector
gem 'devise', '3.0.3'                     # authentication
gem 'figaro', '0.7.0'                     # masking private stuff in opensource
gem 'declarative_authorization', '0.5.7'  # authorization
gem 'aasm', '3.0.22'                      # state machine
gem 'acts_as_list', '0.3.0'               # author order
gem 'will_paginate', '3.0.4'
gem 'bootstrap-will_paginate', '0.0.9'
gem 'simple_form', '2.1.0'

gem 'thinking-sphinx', '3.0.5'
gem 'flying-sphinx', '1.0.0'

# gem 'wicked_pdf', '0.9.6'
gem 'pdfkit', '0.5.4'
# gem 'bcrypt-ruby', '3.0.1'
# gem 'faker', '1.0.1'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '3.2.5'
  gem 'coffee-rails', '3.2.2'
	gem 'uglifier', '1.2.3'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby
  gem 'jquery-datatables-rails', git: 'git://github.com/rweng/jquery-datatables-rails.git'
  gem 'jquery-ui-rails'
end

group :development, :test do
#  gem 'sqlite3', '1.3.5'
  # gem 'rspec-rails', '2.0.1'
  # gem 'guard-rspec', '1.2.1'
  # gem 'guard-spork', '1.5.1'
  
  # gem 'spork', '0.9.2'
	# gem 'sqlite3', '1.3.5'
  gem 'rspec-rails', '2.11.0'
  gem 'guard-rspec', '1.2.1'
  gem 'guard-spork', '1.5.1'
  gem 'childprocess', '0.3.9'
  gem 'spork', '0.9.2'
  gem 'annotate', '2.5.0'
  gem 'factory_girl_rails', '4.2.1'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'mysql2', '0.3.13'  
  gem 'wkhtmltopdf-binary', '0.9.9.1'
end

group :test do
	# gem 'rspec', '2.0.1'
	# gem 'webrat', '0.7.3'
	gem 'database_cleaner', '1.1.1'
	gem 'email_spec', '1.5.0'
  gem 'capybara', '1.1.2'
  gem 'rb-fsevent', '0.9.3', :require => false
  gem 'growl', '1.0.3'
  gem 'cucumber-rails', '1.4.0', :require => false
  gem 'launchy'
end

group :production do
  gem 'rails_12factor'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
