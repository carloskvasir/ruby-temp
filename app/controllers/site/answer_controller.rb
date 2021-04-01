class Site::AnswerController < SiteController
  def question
    params[:answer_id]
  end
end
