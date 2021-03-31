class Site::SearchController < SiteController
  include ActiveRecord::Sanitization::ClassMethods

  def questions
    @questions = Question.includes(:answers)
                         .where('lower(description) LIKE ?', "%#{sanitize_sql_like(params[:term]).downcase}%")
                         .page(params[:page])
  end
end
