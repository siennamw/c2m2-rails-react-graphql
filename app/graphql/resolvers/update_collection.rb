class Resolvers::UpdateCollection < GraphQL::Function
  # arguments passed as "args"
  argument :id, !types.ID

  argument :name, !types.String
  argument :finding_aid_link, types.String
  argument :description, types.String
  argument :repository_id, !types.ID

  # return type from the mutation
  type Types::CollectionType

  # the mutation method
  def call(_obj, args, ctx)
    if ctx[:current_user].blank?
      raise GraphQL::ExecutionError.new("Authentication required")
    end

    repository = Repository.find(args[:repository_id])
    return unless repository

    collection = Collection.find(args[:id])

    attributes = {
      name: args[:name],
      finding_aid_link: args[:finding_aid_link],
      description: args[:description],
      repository_id: repository.id,
      updated_by: ctx[:current_user],
    }

    collection.update!(attributes)

    Event.create!(
      created_by: attributes[:updated_by],
      entity_id: args[:id],
      name: 'UpdateCollection',
      payload: attributes.filter do |k|
        !%i[updated_by].include?(k)
      end
    )

    Collection.find(args[:id])
  rescue ActiveRecord::RecordInvalid => e
    # this would catch all validation errors and translate them to GraphQL::ExecutionError
    GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
  end
end
