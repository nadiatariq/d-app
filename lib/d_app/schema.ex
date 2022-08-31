defmodule DApp.Schema do
  use Absinthe.Schema
  alias DApp.Schema.Middleware

  # Import Types
  import_types(DAppWeb.Schema.Types)

#--------------------------QUERY SECTION--------------------------#
  query do
    @desc "Get a list of students"
    field :get_students, list_of(:user_type) do
      # Resolver
      resolve(&DAppWeb.UserController.get_student_list/3)
    end

    @desc "Get users list by inserted_at"
    field :get_users_list, list_of(:user_type) do
      # Resolver
      middleware(Middleware.Authorize, :any)
      resolve(&DAppWeb.UserController.get_users_list/3)
    end

    @desc "Get list of roles"
    field :get_roles_list, list_of(:user_roles_type) do
      # Resolver
      middleware(Middleware.Authorize, :any)
      resolve(&DAppWeb.UserController.get_roles_list/3)
    end

    @desc "Get list of programs"
    field :get_programs_list, list_of(:program_type) do
      # Resolver
      middleware(Middleware.Authorize, :any)
      resolve(&DAppWeb.AdminController.get_programs_list/3)
    end

    @desc "Get list of semesters"
    field :get_semesters_list, list_of(list_of(:semester_type)) do
      # Resolver
      middleware(Middleware.Authorize, :any)
      resolve(&DAppWeb.AdminController.get_semesters_list/3)
    end

    @desc "Get list of courses"
    field :get_courses_list, list_of(list_of(:course_type)) do
      # Resolver
      middleware(Middleware.Authorize, :any)
      resolve(&DAppWeb.AdminController.get_courses_list/3)
    end
  end

  #--------------------------MUTATION SECTION--------------------------#
  mutation do

    #--------------------------USER API--------------------------#
    @desc "Get User From Token"
    field :get_user_from_jwt, :user_type do
      # Resolver
      arg(:input, non_null(:get_user_from_jwt_input_type))
      resolve(
        fn a, arg, b ->
          case DAppWeb.SessionController.get_user_from_jwt(a, arg, b) do
            {:ok, _last, %{extracted_user: user}} -> {:ok, user}
            {:error, error} -> {:error, error}
          end
        end
      )
    end

    @desc "Create New User"
    field :create_user, :user_type do
      # Resolver
      middleware(Middleware.Authorize, :any)
      arg(:input, non_null(:user_create_input_type))
      resolve(
        fn a, arg, b ->
          case DAppWeb.SessionController.create_user(a, arg, b) do
            {:ok, _last, %{create_user: user}} -> {:ok, user}
            {:error, error} -> {:error, error}
          end
        end
      )
    end

    @desc "Login User"
    field :user_signin, :user_type do
      # Resolver
      arg(:input, non_null(:user_signin_input_type))
      resolve(
        fn a, arg, b ->
          case DAppWeb.SessionController.signin(a, arg, b) do
            {:ok, _last, %{login_user: user}} -> {:ok, user}
            {:error, error} -> {:error, error}
          end
        end
      )
    end

    @desc "Update User"
    field :user_update, :user_type do
      # Resolver
      middleware(Middleware.Authorize, :any)
      arg(:input, non_null(:user_update_input_type))
      resolve(&DAppWeb.UserController.update_user/3)
    end

    @desc "delete User"
    field :user_delete, :user_type do
      # Resolver
      middleware(Middleware.Authorize, :any)
      arg(:input, non_null(:user_delete_input_type))
      resolve(&DAppWeb.UserController.delete_user/3)
    end

    #--------------------------PROGRAM API--------------------------#

    @desc "create program"
    field :create_program, :program_type do
      # Resolver
      middleware(Middleware.Authorize, :any)
      arg(:input, non_null(:create_program_input_type))
      resolve(
        fn a, arg, b ->
          case DAppWeb.AdminController.create_program(a, arg, b) do
            {:ok, _last, %{create_program: program}} -> {:ok, program}
            {:error, error} -> {:error, error}
          end
        end
      )
    end

    @desc "update program"
    field :update_program, :program_type do
      # Resolver
      middleware(Middleware.Authorize, :any)
      arg(:input, non_null(:update_program_input_type))
      resolve(
        fn a, arg, b ->
          case DAppWeb.AdminController.update_program(a, arg, b) do
            {:ok, _last, %{update_program: program}} -> {:ok, program}
            {:error, error} -> {:error, error}
          end
        end
      )
    end

    @desc "delete program"
    field :delete_program, :program_type do
      # Resolver
      middleware(Middleware.Authorize, :any)
      arg(:input, non_null(:delete_program_input_type))
      resolve(
        fn a, arg, b ->
          case DAppWeb.AdminController.delete_program(a, arg, b) do
            {:ok, _last, %{delete_program: program}} -> {:ok, program}
            {:error, error} -> {:error, error}
          end
        end
      )
    end

    #--------------------------SEMESTER API--------------------------#

    @desc "Get Semesters By Program"
    field :get_semesters_by_program, list_of(:semester_type) do
      # Resolver
      middleware(Middleware.Authorize, :any)
      arg(:input, non_null(:get_semesters_by_program_input_type))
      resolve(
        fn a, arg, b ->
          case DAppWeb.AdminController.get_semesters_by_program(a, arg, b) do
            {:ok, _last, %{get_semesters_by_program: semesters}} -> {:ok, semesters}
            {:error, error} -> {:error, error}
          end
        end
      )
    end

    @desc "create semester"
    field :create_semester, :semester_type do
      # Resolver
      middleware(Middleware.Authorize, :any)
      arg(:input, non_null(:create_semester_input_type))
      resolve(
        fn a, arg, b ->
          case DAppWeb.AdminController.create_semester(a, arg, b) do
            {:ok, _last, %{create_semester: semester}} -> {:ok, semester}
            {:error, error} -> {:error, error}
          end
        end
      )
    end

    @desc "update semester"
    field :update_semester, :semester_type do
      # Resolver
      middleware(Middleware.Authorize, :any)
      arg(:input, non_null(:update_semester_input_type))
      resolve(
        fn a, arg, b ->
          case DAppWeb.AdminController.update_semester(a, arg, b) do
            {:ok, _last, %{update_semester: semester}} -> {:ok, semester}
            {:error, error} -> {:error, error}
          end
        end
      )
    end

    @desc "delete semester"
    field :delete_semester, :semester_type do
      # Resolver
      middleware(Middleware.Authorize, :any)
      arg(:input, non_null(:delete_semester_input_type))
      resolve(
        fn a, arg, b ->
          case DAppWeb.AdminController.delete_semester(a, arg, b) do
            {:ok, _last, %{delete_semester: semester}} -> {:ok, semester}
            {:error, error} -> {:error, error}
          end
        end
      )
    end

    #--------------------------COURSE API--------------------------#

    @desc "create course"
    field :create_course, :course_type do
      # Resolver
      middleware(Middleware.Authorize, :any)
      arg(:input, non_null(:create_course_input_type))
      resolve(
        fn a, arg, b ->
          case DAppWeb.AdminController.create_course(a, arg, b) do
            {:ok, _last, %{create_course: course}} -> {:ok, course}
            {:error, error} -> {:error, error}
          end
        end
      )
    end

    @desc "update course"
    field :update_course, :course_type do
      # Resolver
      middleware(Middleware.Authorize, :any)
      arg(:input, non_null(:update_course_input_type))
      resolve(
        fn a, arg, b ->
          case DAppWeb.AdminController.update_course(a, arg, b) do
            {:ok, _last, %{update_course: course}} -> {:ok, course}
            {:error, error} -> {:error, error}
          end
        end
      )
    end

    @desc "delete course"
    field :delete_course, :course_type do
      # Resolver
      middleware(Middleware.Authorize, :any)
      arg(:input, non_null(:delete_course_input_type))
      resolve(
        fn a, arg, b ->
          case DAppWeb.AdminController.delete_course(a, arg, b) do
            {:ok, _last, %{delete_course: course}} -> {:ok, course}
            {:error, error} -> {:error, error}
          end
        end
      )
    end
  end
end
