class Resolvers::DeleteRepository < GraphQL::Function
  # arguments passed as "args"
  argument :id, !types.ID

  # return type from the mutation
  type types.Boolean

  # the mutation method
  def call(_obj, args, ctx)
    if ctx[:current_user].blank?
      raise GraphQL::ExecutionError.new('Authentication required')
    end

    record = Repository.find(args[:id])

    unless record.deletable
      raise GraphQL::ExecutionError.new('Record has associated collections and cannot be deleted')
    end

    record.destroy!

    Event.create!(
      created_by: ctx[:current_user],
      entity_id: record.id,
      name: 'DeleteRepository',
    )

    true
  end
end
