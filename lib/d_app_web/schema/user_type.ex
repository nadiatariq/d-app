defmodule DAppWeb.Schema.UserType do
#  import DAppWeb.Schema.{QuizType}
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: DApp.Repo
  import_types(Absinthe.Type.Custom)

  object :user_type do
    field :first_name, :string
    field :last_name, :string
    field :dob, :date
    field :email, :string
    field :password, :string
    field :token, :string

    field(:role, :user_roles_type, resolve: assoc(:role))
  end
  object :user_roles_type do
    field :id, :string
  end

  input_object :user_signin_input_type do
    field :email, :string
    field :password, :string
  end
  input_object :user_create_input_type do
    field :first_name, :string
    field :last_name, :string
    field :dob, :date
    field :email, :string
    field :password, :string
    field :role_id, non_null :string
  end
  input_object :user_update_input_type do
    field :first_name, :string
    field :last_name, :string
    field :dob, :date
    field :email, :string
    field :password, :string
  end
  input_object :user_delete_input_type do
    field :id, non_null :integer
  end
  input_object :get_user_from_jwt_input_type do
    field :token, non_null :string
  end
end