class Question < ApplicationRecord
  belongs_to :subject, inverse_of: :questions
  has_many :answers
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

  # Kaminari
  paginates_per 5

  # Search _term_ in title of all questions with pagination
  def self.search_in_title(term, page = 0)
    Question.includes(:answers)
           .where('lower(description) LIKE ?', "%#{sanitize_sql_like(term).downcase}%")
           .page(page)

  end

  # Get latest created questions with pagination
  def self.latest_questions_in_page(page)
    Question.includes(:answers)
            .order('created_at desc')
            .page(page)
  end
end
