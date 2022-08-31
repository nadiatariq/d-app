defmodule DApp.Query.ExamTypes do
  @moduledoc """
  The ExamTypes context.
  """

  import Ecto.Query, warn: false
  alias DApp.Repo

  alias DApp.Schema.ExamType

  @doc """
  Returns the list of exam_types.

  ## Examples

      iex> list_exam_types()
      [%Exam_Type{}, ...]

  """
  def list_exam_types do
    Repo.all(ExamType)
  end

  @doc """
  Gets a single exam_type.

  Raises `Ecto.NoResultsError` if the Exam  type does not exist.

  ## Examples

      iex> get_exam_type!(123)
      %Exam_Type{}

      iex> get_exam_type!(456)
      ** (Ecto.NoResultsError)

  """
  def get_exam_type!(id), do: Repo.get!(ExamType, id)

  @doc """
  Creates a exam_type.

  ## Examples

      iex> create_exam_type(%{field: value})
      {:ok, %Exam_Type{}}

      iex> create_exam_type(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_exam_type(attrs \\ %{}) do
    %ExamType{}
    |> ExamType.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a exam_type.

  ## Examples

      iex> update_exam_type(exam_type, %{field: new_value})
      {:ok, %Exam_Type{}}

      iex> update_exam_type(exam_type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_exam_type(%ExamType{} = exam_type, attrs) do
    exam_type
    |> ExamType.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a exam_type.

  ## Examples

      iex> delete_exam_type(exam_type)
      {:ok, %Exam_Type{}}

      iex> delete_exam_type(exam_type)
      {:error, %Ecto.Changeset{}}

  """
  def delete_exam_type(%ExamType{} = exam_type) do
    Repo.delete(exam_type)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking exam_type changes.

  ## Examples

      iex> change_exam_type(exam_type)
      %Ecto.Changeset{data: %Exam_Type{}}

  """
  def change_exam_type(%ExamType{} = exam_type, attrs \\ %{}) do
    ExamType.changeset(exam_type, attrs)
  end
end
