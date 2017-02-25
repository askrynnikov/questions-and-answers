require 'spec_helper'

require 'databasecleaner_helper'

Capybara.default_max_wait_time = 10

RSpec.configure do |config|
  # Capybara.javascript_driver = :webkit
  config.use_transactional_fixtures = false

  config.include AcceptanceHelper, type: :feature
end


