defmodule DApp.Query.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false

  alias DApp.Repo
  alias DApp.Schema.User
  alias DApp.Schema.UserRole

  @doc """
  Returns the list of user.
  """
  def list_user do
    Repo.all(User)
  end

  @doc """
  Returns the list of user that has role user.
  """
  def get_students do
    role = "user"
    from(u in User, where: u.role_id == ^role) |> Repo.all()
  end

  @doc """
  Returns the list of users in descending order
  """
  def get_users_list do
    from(u in User,
      where: u.role_id in ["admin", "student", "teacher"],
      order_by: [desc: u.inserted_at],
    ) |> Repo.all()
  end

  @doc """
  Gets a single user by id
  """
  def get_user(id) do
    query = from(u in User, where: u.id == ^id, preload: [:role])
    case Repo.one(query) do
      nil -> {:error, "user doesn't exist"}
      user -> {:ok, user}
    end
  end

  @doc """
  Gets
  """
  def get_user_by_role(role) do
    query =
      from(
        u in User,
        join: r in UserRole,
        on: r.id == u.role_id,
        where: u.role_id == ^role,
        select: {u.first_name, r.id}
      )
      |> Repo.all()
      |> IO.inspect(label: "customQuery =>")
  end

  @doc """
  Gets a single user by email
  """
  def get_user_by_email(email) do
    query = EASY.Query.build(DApp.Schema.User, %{
      "$where" => %{"email" => email}
    })
    case Repo.one(query) do
      nil -> {:error, :user_does_not_exist}
      user -> {:ok, user}
    end
end

  @doc """
  Creates a user.
  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.
  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.
  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.
  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  @doc """
  Returns the list of user_roles.
  """
  def list_user_roles do
    Repo.all(UserRole)
  end

  @doc """
  Gets a single user_role.

  Raises `Ecto.NoResultsError` if the User role does not exist.

  ## Examples

      iex> get_user_role!(123)
      %UserRole{}

      iex> get_user_role!(456)
      ** (Ecto.NoResultsError)

  """
#  def get_user_role!(id), do: Repo.get!(UserRole, id)

  @doc """
  Creates a user_role.

  ## Examples

      iex> create_user_role(%{field: value})
      {:ok, %UserRole{}}

      iex> create_user_role(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_role(attrs \\ %{}) do
    %UserRole{}
    |> UserRole.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_role.

  ## Examples

      iex> update_user_role(user_role, %{field: new_value})
      {:ok, %UserRole{}}

      iex> update_user_role(user_role, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_role(%UserRole{} = user_role, attrs) do
    user_role
    |> UserRole.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user_role.

  ## Examples

      iex> delete_user_role(user_role)
      {:ok, %UserRole{}}

      iex> delete_user_role(user_role)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_role(%UserRole{} = user_role) do
    Repo.delete(user_role)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_role changes.

  ## Examples

      iex> change_user_role(user_role)
      %Ecto.Changeset{data: %UserRole{}}

  """
  def change_user_role(%UserRole{} = user_role, attrs \\ %{}) do
    UserRole.changeset(user_role, attrs)
  end
end