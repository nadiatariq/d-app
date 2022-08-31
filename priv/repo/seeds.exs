# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     DApp.DApp.Repo.insert!(%DApp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

DApp.Repo.insert(%DApp.Schema.UserRole{id: "admin"})
DApp.Repo.insert(%DApp.Schema.UserRole{id: "student"})
DApp.Repo.insert(%DApp.Schema.UserRole{id: "teacher"})

DApp.Repo.insert(%DApp.Schema.User{first_name: "Nadia", last_name: "Tariq", dob: ~D[1999-12-16], email: "nadiaexpt@gmail.com", password: Argon2.hash_pwd_salt("123"), role_id: "admin"})
DApp.Repo.insert(%DApp.Schema.User{first_name: "Wasi", last_name: "Ur Rahman", dob: ~D[1999-07-26], email: "wasibiit@gmail.com", password: Argon2.hash_pwd_salt("123"), role_id: "admin"})
DApp.Repo.insert(%DApp.Schema.User{first_name: "Nadia", last_name: "Tariq", dob: ~D[1999-12-16], email: "nadiaexpt@ls.com", password: Argon2.hash_pwd_salt("123"), role_id: "teacher"})
DApp.Repo.insert(%DApp.Schema.User{first_name: "Api", last_name: "Saeeda", dob: ~D[1999-12-16], email: "apisaeedat@ls.com", password: Argon2.hash_pwd_salt("123"), role_id: "teacher"})
DApp.Repo.insert(%DApp.Schema.User{first_name: "Awais", last_name: "Khalid", dob: ~D[1996-01-12], email: "awaiskhaild@gmail.com", password: Argon2.hash_pwd_salt("123"), role_id: "student"})
DApp.Repo.insert(%DApp.Schema.User{first_name: "M", last_name: "Touseef", dob: ~D[1995-02-16], email: "mtouseef@gmail.com", password: Argon2.hash_pwd_salt("123"), role_id: "student"})
DApp.Repo.insert(%DApp.Schema.User{first_name: "John", last_name: "Doe", dob: ~D[1994-05-02], email: "john@doe.com", password: Argon2.hash_pwd_salt("123"), role_id: "student"})

DApp.Repo.insert(%DApp.Schema.Program{id: "bscs", duration: "4 years"})
DApp.Repo.insert(%DApp.Schema.Program{id: "bsit", duration: "4 years"})
DApp.Repo.insert(%DApp.Schema.Program{id: "bsurdu", duration: "4 years"})
DApp.Repo.insert(%DApp.Schema.Program{id: "bsmath", duration: "4 years"})

DApp.Repo.insert(%DApp.Schema.Semester{code: "S01", program_id: "bscs"})
DApp.Repo.insert(%DApp.Schema.Semester{code: "S02", program_id: "bscs"})
DApp.Repo.insert(%DApp.Schema.Semester{code: "S03", program_id: "bscs"})
DApp.Repo.insert(%DApp.Schema.Semester{code: "S04", program_id: "bscs"})

#DApp.Repo.insert(%DApp.Schema.Question{question: "What Would You Drink?", options: %{"a" => "Cold Coffee", "b" => "Hot Coffee"}})
#DApp.Repo.insert(%DApp.Schema.Question{question: "What Would You Choose?", options: %{"a" => "Rose", "b" => "Sun Flower", "c" => "Lily", "d" => "Iris"}})
#DApp.Repo.insert(%DApp.Schema.Question{question: "What Would You Prefer?", options: %{"a" => "Tattoo", "b" => "No Tattoo"}})
#DApp.Repo.insert(%DApp.Schema.Question{question: "What Would You Like To Watch?", options: %{"a" => "Movies", "b" => "TV-Series"}})
#DApp.Repo.insert(%DApp.Schema.Question{question: "What Would You Like To Do In Spare Time?", options: %{"a" => "Sports", "b" => "Video Gaming", "c" => "Movies", "d" => "Social Media"}})