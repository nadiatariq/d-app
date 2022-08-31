defmodule DAppWeb.AdminController do
  import Sage
  use DAppWeb, :controller
  alias DApp.AdminHelper, as: Data

  @doc """
  Program Controller Functions
  """
  def get_programs_list(_, _params, _) do
    {:ok, Data.get_programs_list()}
  end

  def create_program(_, params, _) do
    new()
    |> run(:authenticate, &authenticate_program/2, &abort/3)
    |> run(:create_program, &create_program/2, &abort/3)
    |> transaction(DApp.Repo, params)
  end

  def update_program(_, params, _) do
    new()
    |> run(:update_program, &update_program/2, &abort/3)
    |> transaction(DApp.Repo, params)
  end

  def delete_program(_, params, _) do
    new()
    |> run(:delete_program, &delete_program/2, &abort/3)
    |> transaction(DApp.Repo, params)
  end

  defp authenticate_program(_, %{input: %{id: id}}) do
    case Data.get_program(id) do
      {:error, :program_does_not_exist} -> {:ok, :create_program}
      {:ok, _program} -> {:error, ["program already exist"]}
    end
  end
  defp create_program(%{authenticate: :create_program}, %{input: data}) do
    case Data.create_program(data) do
      {:ok, program} -> {:ok, program}
      _ -> {:error, ["you cannot create program"]}
    end
  end
  defp update_program(_, %{input: data}) do
    case Data.update_program(data) do
      {:ok, program} -> {:ok, program}
      _ -> {:error, ["you cannot update program"]}
    end
  end
  defp delete_program(_, %{input: data}) do
    case Data.delete_program(data) do
      {:ok, program} -> {:ok, program}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Semester Controller Functions.
  """
  def get_semesters_by_program(_, params, _) do
    new()
    |> run(:get_semesters_by_program, &get_semesters/2, &abort/3)
    |> transaction(DApp.Repo, params)
  end

  def get_semesters_list(_, _params, _) do
    {:ok, Data.get_semester_list()}
  end

  def create_semester(_, params, _) do
    new()
    |> run(:authenticate, &authenticate_semester_create/2, &abort/3)
    |> run(:create_semester, &create_semester/2, &abort/3)
    |> transaction(DApp.Repo, params)
  end

  def update_semester(_, params, _) do
    new()
    |> run(:authenticate, &authenticate_semester_update/2, &abort/3)
    |> run(:update_semester, &update_semester/2, &abort/3)
    |> transaction(DApp.Repo, params)
  end

  def delete_semester(_, params, _) do
    new()
    |> run(:authenticate, &authenticate_semester_delete/2, &abort/3)
    |> run(:delete_semester, &delete_semester/2, &abort/3)
    |> transaction(DApp.Repo, params)
  end


  defp authenticate_semester_create(_, %{input: %{program_name: program_id, code: code}}) do
    with {:ok, _prograxm} <- Data.get_program(program_id),
         {:error, :semester_does_not_exist} <- Data.get_semester(code, program_id) do
      {:ok, :can_create_semester}
    else
      {:error, :program_does_not_exist} -> {:error, ["This Program Doesn't Exist"]}
      {:ok, _semester} -> {:error, ["This semester already exist for this program"]}
    end
  end
  defp create_semester(%{authenticate: :can_create_semester}, %{input: %{code: code, program_name: program_id}}) do
    case Data.create_semester(%{code: code, program_id: program_id}) do
      {:ok, semester} -> {:ok, semester}
      _ -> {:error, ["You Cannot Create Semester"]}
    end
  end
  defp authenticate_semester_update(_, %{input: %{program_name: program_id, code: code}}) do
    with {:ok, _program} <- Data.get_program(program_id),
         {:ok, _semester} <- Data.get_semester(code, program_id) do
      {:ok, :can_update_semester}
    else
      {:error, :program_does_not_exist} -> {:error, ["This Program Doesn't Exist"]}
      {:error, :semester_does_not_exist} -> {:error, ["This semester Doesn't Exist for this program"]}
    end
  end
  defp update_semester(%{authenticate: :can_update_semester}, %{input: data}) do
    case Data.update_semester(data) do
      {:ok, semester} -> {:ok, semester}
      _ -> {:error, ["You Cannot Update Semester"]}
    end
  end
  defp authenticate_semester_delete(_, %{input: %{program_name: program_id, code: code}}) do
    with {:ok, _program} <- Data.get_program(program_id),
         {:ok, _semester} <- Data.get_semester(code, program_id) do
      {:ok, :can_delete_semester}
    else
      {:error, :program_does_not_exist} -> {:error, ["This Program Doesn't Exist"]}
      {:error, :semester_does_not_exist} -> {:error, ["This semester Doesn't Exist for this program"]}
    end
  end
  defp delete_semester(%{authenticate: :can_delete_semester}, %{input: data}) do
    case Data.delete_semester(data) do
      {:ok, semester} -> {:ok, semester}
      {:error, error} -> {:error, error}
    end
  end
  defp get_semesters(_, %{input: %{program_name: program_id}}) do
    with {:ok, _program} <- Data.get_program(program_id),
         {:ok, semesters} <- Data.get_semesters_by_program(program_id) do
      {:ok, semesters}
    else
      {:error, :program_does_not_exist} -> {:error, ["This Program Doesn't Exist"]}
      {:error, :semesters_does_not_exist} -> {:error, ["Semesters Doesn't Exist For This Program"]}
    end
  end

  @doc """
  Courses Controller Functions
  """
  def get_courses_list(_, _params, _) do
    {:ok, Data.get_courses_list()}
  end

  def create_course(_, params, _) do
    new()
    |> run(:authenticate, &authenticate_course/2, &abort/3)
    |> run(:create_course, &create_course/2, &abort/3)
    |> transaction(DApp.Repo, params)
  end

  def update_course(_, params, _) do
    new()
    |> run(:update_course, &update_course/2, &abort/3)
    |> transaction(DApp.Repo, params)
  end

  def delete_course(_, params, _) do
    new()
    |> run(:delete_course, &delete_course/2, &abort/3)
    |> transaction(DApp.Repo, params)
  end


  defp authenticate_course(_, %{input: %{course_code: course_code, program_name: program_id, semester_code: semester_name}}) do
    with {:ok, _program} <- Data.get_program(program_id),
         {:ok, %{id: semester_id}} <- Data.get_semester(semester_name, program_id),
         {:error, :course_does_not_exist} <- Data.get_course(course_code, semester_id, program_id) do
      {:ok, %{status: :can_create_course, semester_id: semester_id}}
    else
      {:error, :program_does_not_exist} -> {:error, ["This Program Doesn't Exist"]}
      {:error, :semester_does_not_exist} -> {:error, ["This semester Doesn't Exist for this program"]}
      {:ok, _course} -> {:error, ["This Course Already Exist For This Semester"]}

    end
    rescue
    any ->
      IO.inspect("=========RESCUE==============START=====================")
      IO.inspect(any)
      IO.inspect("=======================END=======================")
  end
  defp create_course(%{authenticate: %{status: :can_create_course, semester_id: semester_id}}, %{input: data}) do
    case Data.create_course(Map.merge(data, %{semester_code: semester_id})) do
      {:ok, course} -> {:ok, course}
      _ -> {:error, ["You Cannot Create course"]}
    end
  end
  defp update_course(_, %{input: data}) do
    case Data.update_course(data) do
      {:ok, course} -> {:ok, course}
      _ -> {:error, ["You Cannot Update course"]}
    end
  end
  defp delete_course(_, %{input: data}) do
    case Data.delete_course(data) do
      {:ok, course} -> {:ok, course}
      {:error, error} -> {:error, error}
    end
  end

  defp abort(_, _, _), do: :abort
end