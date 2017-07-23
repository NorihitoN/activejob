class Task < ApplicationRecord
  def exec(message)
    Rails.logger.info(message)
  end
end