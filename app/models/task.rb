class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true
  validates_length_of :description, minimum: 5
  validates :expire_at, inclusion: { in: (Date.today..Date.today+5.years) }
  enum status: %i(todo done)

  scope :q, ->(q) { where("title LIKE '%#{q}%'") if q }
  scope :status, -> (status) { where status: status if status && status != 'all' }
end
