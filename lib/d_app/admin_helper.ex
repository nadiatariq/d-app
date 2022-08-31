defmodule DApp.AdminHelper do
  @moduledoc """
  This is the Admin API for the data layer
  """
  alias DApp.Query.Courses, as: Query

  @doc """
  Programs Helper Functions
  """

  def get_program(params), do: Query.get_program(params)
  def get_programs_list(), do: Query.get_programs_list()
  def create_program(params), do: Query.create_program(params)

  def delete_program(%{id: id}) do
    id
    |> Query.get_program()
    |> Query.delete_program()
  end

  def update_program(%{id: id} = params) do
    id
    |> Query.get_program()
    |> Query.update_program(params)
  end

  @doc """
  Semester Helper Functions
  """

  def get_semester(code, program_id), do: Query.get_semester(code, program_id)
  def get_semesters_by_program(program_id), do: Query.get_semesters_by_program(program_id)
  def get_semester_list(), do: Query.get_semester_list()
  def create_semester(params), do: Query.create_semester(params)

  def update_semester(%{code: code, program_name: program_id}) do
    code
    |> Query.get_semester(program_id)
    |> Query.update_semester(%{code: code, program_id: program_id})
  end

  def delete_semester(%{code: code, program_name: program_id}) do
    code
    |> Query.get_semester(program_id)
    |> Query.delete_semester()
  end

  @doc """
  Courses Helper Functions
  """

  def get_courses_list(), do: Query.get_courses_list()
  def get_course(course_code, semester_code, program_id), do: Query.get_course(course_code, semester_code, program_id)
  def create_course(%{course_code: course_code, program_name: program_id, semester_code: semester_id, title: title, credit_hours: credit_hours}),
      do: Query.create_course(%{course_code: course_code, program_id: program_id, semester_id: semester_id, title: title, credit_hours: credit_hours})

  def delete_course(%{id: id}) do
    id
    |> Query.get_course()
    |> Query.delete_course()
  end

  def update_course(%{id: id, name: name, program_name: program_id}) do
    id
    |> Query.get_course()
    |> Query.update_course(%{name: name, program_id: program_id})
  end
end
