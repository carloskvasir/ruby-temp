class UserStatistic < ApplicationRecord
  belongs_to :user

  def self.set_statistic(answer, current_user)
    if !!current_user
      user_statistic = UserStatistic.find_or_create_by(user: current_user)
      answer.correct? ?
        user_statistic.right_questions += 1 :
        user_statistic.wrong_questions += 1

      user_statistic.save
    end
  end

  # Virtual Attributes

  # Get total of questions answered
  def total_questions
    self.right_questions + self.wrong_questions
  end
end
