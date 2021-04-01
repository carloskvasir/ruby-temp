class Site::SearchController < SiteController

  def questions
    @questions = Question.search_in_title(params[:term], params[:page])
  end
end
