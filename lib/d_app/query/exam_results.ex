defmodule DApp.Query.ExamResults do
  @moduledoc """
  The ExamResults context.
  """

  import Ecto.Query, warn: false
  alias DApp.Repo

  alias DApp.Schema.ExamResult

  @doc """
  Returns the list of exam_results.

  ## Examples

      iex> list_exam_results()
      [%ExamResult{}, ...]

  """
  def list_exam_results do
    Repo.all(ExamResult)
  end

  @doc """
  Gets a single exam_result.

  Raises `Ecto.NoResultsError` if the Exam  result does not exist.

  ## Examples

      iex> get_exam_result!(123)
      %Exam_Result{}

      iex> get_exam_result!(456)
      ** (Ecto.NoResultsError)

  """
  def get_exam_result!(id), do: Repo.get!(ExamResult, id)

  @doc """
  Creates a ExamResult.

  ## Examples

      iex> create_ExamResult(%{field: value})
      {:ok, %ExamResult{}}

      iex> create_exam_result(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_exam_result(attrs \\ %{}) do
    %ExamResult{}
    |> ExamResult.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a ExamResult.

  ## Examples

      iex> update_exam_result(exam_result, %{field: new_value})
      {:ok, %ExamResult{}}

      iex> update_exam_result(exam_result, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_exam_result(%ExamResult{} = exam_result, attrs) do
    exam_result
    |> ExamResult.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a exam_result.

  ## Examples

      iex> delete_exam_result(exam_result)
      {:ok, %ExamResult{}}

      iex> delete_exam_result(exam_result)
      {:error, %Ecto.Changeset{}}

  """
  def delete_exam__result(%ExamResult{} = exam__result) do
    Repo.delete(exam__result)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking exam__result changes.

  ## Examples

      iex> change_exam__result(exam__result)
      %Ecto.Changeset{data: %Exam_Result{}}

  """
  def change_exam__result(%ExamResult{} = exam__result, attrs \\ %{}) do
    ExamResult.changeset(exam__result, attrs)
  end
end
