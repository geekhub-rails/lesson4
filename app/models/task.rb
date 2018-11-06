class Task < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 2 }
  validate :expiration_date
  
  enum status: [:neww, :done]

  def expiration_date
    if expire_at.present? && expire_at.past?
      errors.add(:expire_at, "can't be in the past")
    end
  end  
end
