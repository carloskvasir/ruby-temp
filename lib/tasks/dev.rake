namespace :dev do
  DEFAULT_PASSWORD = 123456

  desc "Configure the development environment"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Drop DB") {%x(rails db:drop)}
      show_spinner("Create DB") {%x(rails db:create)}
      show_spinner("Migrate DB") {%x(rails db:migrate)}
      show_spinner("create adm") {%x(rails dev:add_default_admin)}
      show_spinner("create user") {%x(rails dev:add_default_user)}
    else
      puts 'Run just in development'
    end
  end

  private

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

  def show_spinner(msg_start, msg_end = "(done)")
    spinner = TTY::Spinner.new(":spinner  #{msg_start}", format: :dots)
    spinner.auto_spin
    yield
    spinner.success("#{msg_end}")
  end
end
