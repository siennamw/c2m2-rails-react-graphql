require 'test_helper'

class Resolvers::CreateMaterialFormatTest < ActiveSupport::TestCase
  def perform(args = {})
    Resolvers::CreateMaterialFormat.new.call(nil, args, {})
  end

  test 'creating new material format' do
    name = 'new material format'
    description = 'awesome material format'

    material_format = perform(
    name: name,
    description: description,
    )

    assert material_format.persisted?
    assert_equal material_format.name, name
    assert_equal material_format.description, description
  end
end