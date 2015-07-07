login_names = %w(takuya)

login_names.each_with_index do |name, index|
  Administrator.create({
    login_name: name,
    hashed_password: BCrypt::Password.create("password")
  })
end