require 'test_helper'

class Resolvers::DeleteWorkTest < ActiveSupport::TestCase
  def perform(args = {}, current_user = @new_cataloger)
    Resolvers::DeleteWork.new.call(
      nil,
      args,
      { current_user: current_user }
    )
  end

  setup do
    @cataloger = Cataloger.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
    )
    @new_cataloger = Cataloger.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
    )

    media_type = MediaType.create!(
      name: 'media type',
      created_by: @cataloger,
    )
    material_format = MaterialFormat.create!(
      name: 'material format',
      created_by: @cataloger,
    )

    @work = Work.create!(
      title: 'Work 1',
      year_start: 1998,
      media_type: media_type,
      created_by: @cataloger,
    )
    @work2 = Work.create!(
      title: 'Work 2',
      year_start: 1998,
      media_type: media_type,
      created_by: @cataloger,
    )
    @work_with_resources = Work.create!(
      title: 'Work with work',
      year_start: 1998,
      media_type: media_type,
      created_by: @cataloger,
    )

    repository = Repository.create!(
      name: 'Parent Repo 1',
      location: 'Boulder, CO',
      created_by: @cataloger,
    )
    collection = Collection.create!(
      name: 'Collection 1',
      finding_aid_link: 'http://www.collection.com',
      repository: repository,
      created_by: @cataloger,
    )
    Resource.create!(
      work: @work_with_resources,
      material_format: material_format,
      collections: [collection],
      created_by: @cataloger,
    )
  end

  test 'unauthenticated user attempting to delete a work' do
    assert_raises GraphQL::ExecutionError do
      result = perform({ id: @work.id }, nil)
      assert_equal 'Authentication required', result.message
    end

    assert Work.exists?(@work.id), true
  end

  test 'deleting a work without resources' do
    result = perform(id: @work.id)
    assert result, true
    assert_raises ActiveRecord::RecordNotFound do
      Work.find(@work.id)
    end
  end

  test 'creates the expected Event' do
    event_count = Event.count
    perform(id: @work2.id)

    assert event_count + 1, Event.count

    event = Event.find_by(entity_id: @work2.id)

    # event record
    assert_equal @new_cataloger, event.created_by
    assert_equal 'DeleteWork', event.name
    assert_equal @work2.id, event.entity_id

    # event payload
    assert_empty event.payload
  end

  test 'attempting to delete a work with resources fails and returns expected error' do
    assert_raises GraphQL::ExecutionError do
      result = perform(id: @work_with_resources.id)
      assert_equal 'Invalid input: Record has associated resources and cannot be deleted', result.message
      assert Work.exists?(@work_with_resources.id), true
    end
  end
end
