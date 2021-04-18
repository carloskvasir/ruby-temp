namespace :dev do
  DEFAULT_PASSWORD = 123456
  DEFAULT_FILES_PATH = File.join(Rails.root, 'lib','tmp')

  desc "Configure the development environment"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Drop DB") {%x(rails db:drop)}
      show_spinner("Create DB") {%x(rails db:create)}
      show_spinner("Migrate DB") {%x(rails db:migrate)}
    end
    show_spinner("create adm") {%x(rails dev:add_default_admin)}
    show_spinner("create user") {%x(rails dev:add_default_user)}
    show_spinner("Create extra admins") {%x(rails dev:add_extras_admins)}
    show_spinner("Create extra users") { add_extras_users }
   # else
   #   puts 'Run just in development'
   # end
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
      first_name: 'Carlos',
      last_name: 'Lima',
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

  desc 'Reset questions counter in Subject'
  task reset_subject_counter: :environment do
    show_spinner("Resetting subject counter") do
      Subject.find_each do |subject|
        Subject.reset_counters(subject.id, :questions)
      end
    end
  end

  private

  # Create 10 extras Users
  def add_extras_users
    10.times do
      User.create!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
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

  def create_questions_and_answers
    Subject.all.each do |subject|
      rand(5..10).times do |_i|
        params = create_question_params(subject)
        answers_array = params[:question][:answers_attributes]

        add_answers(answers_array)
        elect_true_answer(answers_array)

        Question.create!(params[:question])
      end
    end
  end

  def create_question_params(subject = Subject.all.sample)
    {
      question: {
        description: "#{Faker::Lorem.paragraph} #{Faker::Lorem.question}",
        subject: subject,
        answers_attributes: []
      }
    }
  end

  def create_answer_params(correct = false)
    { description: Faker::Lorem.sentence, correct: correct}
  end

  def add_answers(answers_array = [])
    rand(2..5).times do |_j|
      answers_array.push(
        create_answer_params(false)
      )
    end
  end

  def elect_true_answer(answers_array = [])
    selected_index = rand(answers_array.size)
    answers_array[selected_index] =  create_answer_params(true)
  end

  def show_spinner(msg_start, msg_end = "(done)")
    spinner = TTY::Spinner.new(":spinner  #{msg_start}", format: :dots)
    spinner.auto_spin
    yield
    spinner.success("#{msg_end}")
  end
end
