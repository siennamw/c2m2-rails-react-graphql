require 'test_helper'

class Resolvers::CreateComposerTest < ActiveSupport::TestCase
  def perform(args = {})
    Resolvers::CreateComposer.new.call(nil, args, { current_user: @cataloger })
  end

  setup do
    @cataloger = Cataloger.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
    )
  end

  test 'creating new composer' do
    name = 'Claude Debussy'
    imdb_link = 'example.com/debussy'

    composer = perform(
      name: name,
      imdb_link: imdb_link,
    )

    assert composer.persisted?
    assert_not_empty composer.id
    assert_equal composer.name, name
    assert_equal composer.imdb_link, imdb_link
    assert_equal composer.created_by, @cataloger
  end

  test 'creating composer creates expected Event' do
    event_count = Event.count
    name = 'Josquin Desprez'
    imdb_link = 'example.com/josquin'

    record = perform(
      name: name,
      imdb_link: imdb_link,
    )

    assert event_count + 1, Event.count

    event = Event.find_by(entity_id: record.id)
    event_payload = event.payload.to_h

    # event record
    assert_equal record.created_by, event.created_by
    assert_equal 'CreateComposer', event.name
    assert_equal record.id, event.entity_id

    # event payload
    assert_equal record.name, event_payload['name']
    assert_equal record.imdb_link, event_payload['imdb_link']
  end

  test 'creating new composer with predetermined ID' do
    name = 'Elizabeth I'
    imdb_link = 'example.com/liz'
    id = SecureRandom.uuid

    composer = perform(
      id: id,
      name: name,
      imdb_link: imdb_link,
    )

    assert composer.persisted?
    assert_equal composer.id, id
    assert_equal composer.name, name
    assert_equal composer.imdb_link, imdb_link
    assert_equal composer.created_by, @cataloger
  end

  test 'duplicate name returns expected error' do
    perform(
      name: 'Clark Kent',
    )

    result = perform(
      name: 'Clark Kent',
    )

    assert_instance_of GraphQL::ExecutionError, result
    assert_equal 'Invalid input: Name has already been taken', result.message
  end

  test 'duplicate imdb_link returns expected error' do
    imdb_link = 'https://www.imdb.com/name/nm0461360/'

    perform(
      name: 'Mark Knopfler',
      imdb_link: imdb_link,
    )

    result = perform(
      name: 'Not Mark Knopfler',
      imdb_link: imdb_link,
    )

    assert_instance_of GraphQL::ExecutionError, result
    assert_equal 'Invalid input: Imdb link has already been taken', result.message
  end

  test 'query params are stripped from imdb_link' do
    imdb_link = 'https://www.imdb.com/name/nm0002354/?ref_=fn_al_nm_1'
    name = 'John Williams'

    composer = perform(
      name: name,
      imdb_link: imdb_link,
    )

    assert composer.persisted?
    assert_equal 'https://www.imdb.com/name/nm0002354/', composer.imdb_link
  end
end
