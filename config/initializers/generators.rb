Rails.application.config.generators do |g|
  # by default, primary keys are UUIDs
  g.orm :active_record, primary_key_type: :uuid, generate_method: 'gen_random_uuid()'
end
