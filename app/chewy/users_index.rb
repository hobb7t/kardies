class UsersIndex < Chewy::Index
  settings analysis: {
    analyzer: {
      default: {
        tokenizer: 'whitespace'
      }
    }
  }

  def self.confirmed
    filter(exists: { field: 'confirmed_at' })
  end

  define_type User.includes(:user_detail) do
    field :username, :email, :confirmed_at
    field :is_signed_in, type: :boolean
    field :state, value: ->(user) { user.user_detail.state }
    field :age, value: ->(user) { user.user_detail.age }
    field :gender, value: ->(user) { user.user_detail.gender }
    field :created, type: 'date', include_in_all: false,
                    value: -> { created_at }
  end
end
