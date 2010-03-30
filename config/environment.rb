RAILS_GEM_VERSION = '2.3.3' unless defined? RAILS_GEM_VERSION


require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|

  config.gem "authlogic"
  config.gem "matthuhiggins-foreigner", :lib => "foreigner", :source => "http://gemcutter.org"
  config.gem "will_paginate", :source => "http://gemcutter.org"
  
  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Activate observers that should always be running
  config.active_record.observers = :stock_product_observer, :user_observer

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'Mexico City'

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  #config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
  config.i18n.load_path += Dir[File.join(RAILS_ROOT, 'config', 'locales', '**', '*.{rb,yml}')]
  config.i18n.default_locale = :en
  
  LOCALES = ['en', 'es']
  
end
