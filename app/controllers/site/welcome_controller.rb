class Site::WelcomeController < SiteController
  def index
    @questions = Question.latest_questions_in_page(params[:page])
  end
end
