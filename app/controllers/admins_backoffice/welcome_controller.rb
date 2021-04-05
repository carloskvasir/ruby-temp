class AdminsBackoffice::WelcomeController < AdminsBackofficeController
  def index
    @total_questions = AdminStatistic.total_questions.value
    @total_users = AdminStatistic.total_users.value
  end
end
