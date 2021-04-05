class Question < ApplicationRecord
  belongs_to :subject, counter_cache: true, inverse_of: :questions
  has_many :answers
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

  # Callback
  after_create :set_statistic

  # Kaminari
  paginates_per 5

  # Search _term_ in title of all questions with pagination
  scope :search_in_title, -> (term, page = 0) {
    includes(:answers)
           .where('lower(description) LIKE ?', "%#{sanitize_sql_like(term).downcase}%")
           .page(page)
  }

  # Search _term_ in subject of all questions with pagination
  scope :search_in_subject, -> (subject_id, page = 0) {
    includes(:answers, :subject).where(subject_id: subject_id).page(page)
  }

  # Get latest created questions with pagination
  scope :latest_questions_in_page, -> (page) {
    includes(:answers)
            .order('created_at desc')
            .page(page)
  }

  private

  def set_statistic
    AdminStatistic.set_event(AdminStatistic::EVENTS[:total_questions])
  end
end
