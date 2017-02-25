require 'spec_helper'

require 'databasecleaner_helper'

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.include AcceptanceHelper, type: :feature
end


