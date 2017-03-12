require 'spec_helper'

require 'databasecleaner_helper'

# require 'capybara/webkit/matchers'
require 'capybara/poltergeist'

Capybara.javascript_driver = :poltergeist

Capybara.save_path = "./tmp/capybara_output"

# для отладки тестов (pry внутри теста)
Capybara.server_host = "0.0.0.0"
Capybara.server_port = 3100

# Capybara.register_driver :poltergeist do |app|
#   # Set to log all javascript console messages to file
#   Capybara::Poltergeist::Driver.new(app)
#   # Capybara::Poltergeist::Driver.new(app, js_errors: false, phantomjs_logger: File.open('log/test_phantomjs.log', 'a'))
#
#   # Set to log all javascript console messages to STDOUT
#   #Capybara::Poltergeist::Driver.new(app, js_errors: false)
# end

Capybara.default_max_wait_time = 10
# Capybara.automatic_reload = true

RSpec.configure do |config|
  # Capybara.javascript_driver = :webkit
  config.use_transactional_fixtures = false

  # config.include AcceptanceMacros, type: :feature
  config.include AcceptanceHelper, type: :feature
  # config.include Capybara::Webkit::RspecMatchers, type: :feature
end


