class Resolvers::UpdateComposer < GraphQL::Function
  # arguments passed as "args"
  argument :id, !types.ID

  argument :name, !types.String
  argument :imdb_link, types.String

  # return type from the mutation
  type Types::ComposerType

  # the mutation method
  def call(_obj, args, ctx)
    if ctx[:current_user].blank?
      raise GraphQL::ExecutionError.new("Authentication required")
    end

    composer = Composer.find(args[:id])

    attributes = {
      name: args[:name],
      imdb_link: args[:imdb_link],
      updated_by: ctx[:current_user],
    }

    composer.update!(attributes)

    Event.create!(
      created_by: attributes[:updated_by],
      entity_id: args[:id],
      name: 'UpdateComposer',
      payload: attributes.filter do |k|
        !%i[updated_by].include?(k)
      end
    )

    Composer.find(args[:id])
  rescue ActiveRecord::RecordInvalid => e
    # this would catch all validation errors and translate them to GraphQL::ExecutionError
    GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
  end
end
