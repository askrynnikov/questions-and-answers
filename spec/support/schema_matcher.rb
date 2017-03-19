RSpec::Matchers.define :match_response_schema do |schema|
  match do |data|
    JSON::Validator.validate(schema, data, strict: true)
  end
end