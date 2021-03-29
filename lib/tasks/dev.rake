namespace :dev do
  DEFAULT_PASSWORD = 123456
  DEFAULT_FILES_PATH = File.join(Rails.root, 'lib','tmp')

  desc "Configure the development environment"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Drop DB") {%x(rails db:drop)}
      show_spinner("Create DB") {%x(rails db:create)}
      show_spinner("Migrate DB") {%x(rails db:migrate)}
      show_spinner("create adm") {%x(rails dev:add_default_admin)}
      show_spinner("create user") {%x(rails dev:add_default_user)}
      show_spinner("Create extra admins") {%x(rails dev:add_extras_admins)}
      show_spinner("Create extra users") { add_extras_users }
      show_spinner("Create default subjects") { create_default_subjects }
    else
      puts 'Run just in development'
    end
  end

  desc 'Create default Admin'
  task add_default_admin: :environment do
    Admin.create!(
      email: 'admin@admin.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  desc 'Create default User'
  task add_default_user: :environment do
    User.create!(
      email: 'user@user.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  desc 'Create 10 admins'
  task add_extras_admins: :environment do
    10.times do
      Admin.create!(
        email: Faker::Internet.email,
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD
      )
    end
  end

  private

  # Create 10 extras Users
  def add_extras_users
    10.times do
      User.create!(
        email: Faker::Internet.email,
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD
      )
    end
  end

  def create_default_subjects
    file_name = 'subjects.txt'
    file_path = File.join(DEFAULT_FILES_PATH, file_name)

    File.open(file_path, 'r').each do |line|
      Subject.create_or_find_by(description: line.strip)
    end
  end

  def show_spinner(msg_start, msg_end = "(done)")
    spinner = TTY::Spinner.new(":spinner  #{msg_start}", format: :dots)
    spinner.auto_spin
    yield
    spinner.success("#{msg_end}")
  end
end
