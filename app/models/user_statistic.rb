class UserStatistic < ApplicationRecord
  belongs_to :user

  # Virtual Attributes

  # Get total of questions answered
  def total_questions
    self.right_questions + self.wrong_questions
  end
end
