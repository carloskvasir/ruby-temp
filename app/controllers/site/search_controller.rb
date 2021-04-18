class Site::SearchController < SiteController

  def questions
    @questions = Question.search_in_title(params[:term], params[:page])
  end

  def subject
    @questions = Question.search_in_subject(params[:subject_id], params[:page])
  end
end
