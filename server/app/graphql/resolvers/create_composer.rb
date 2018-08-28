class Resolvers::CreateComposer < GraphQL::Function
  # arguments passed as "args"
  argument :name, !types.String
  argument :imdb_link, types.String

  # return type from the mutation
  type Types::ComposerType

  # the mutation method
  def call(_obj, args, ctx)
    if ctx[:current_user].blank?
      raise GraphQL::ExecutionError.new("Authentication required")
    end

    Composer.create!(
      name: args[:name],
      imdb_link: args[:imdb_link],
    )

  rescue ActiveRecord::RecordInvalid => e
    # this would catch all validation errors and translate them to GraphQL::ExecutionError
    GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
  end
end
