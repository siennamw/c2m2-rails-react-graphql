require 'search_object/plugin/graphql'

class Resolvers::SearchDirectors
  # include SearchObject for GraphQL
  include SearchObject.module(:graphql)
  # include search helpers (apply_filter, apply_first, and apply_skip)
  include SearchHelper

  # scope is starting point for search
  scope { Director.all }

  # return type
  type !types[Types::DirectorType]

  DirectorFilter = GraphQL::InputObjectType.define do
    name 'DirectorFilter'

    argument :OR, -> { types[DirectorFilter] }
    argument :name_contains, types.String
  end

  option :filter, type: DirectorFilter, with: :apply_filter
  option :first, type: types.Int, with: :apply_first
  option :skip, type: types.Int, with: :apply_skip

  def normalize_filters(value, branches = [])
    scope = Director.all

    # add like SQL conditions
    scope = scope.where('name ILIKE ?', "%#{value['name_contains']}%") if value['name_contains']

    branches << scope

    # continue to normalize down
    value['OR'].reduce(branches) { |s, v| normalize_filters(v, s) } if value['OR'].present?

    branches
  end
end
