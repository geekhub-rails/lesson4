class Task < ApplicationRecord
  DEFAULT_PAGE_SIZE = 10

  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true
  validates_length_of :description, minimum: 5
  validates :expire_at, inclusion: { in: (Date.today..Date.today+5.years) }
  enum status: %i(todo done)

  scope :search, ->(search_query) { where("title LIKE '%#{search_query}%'") if search_query }

  scope :get_page, ->(cur_page, size = DEFAULT_PAGE_SIZE) { page(cur_page).per(size) if cur_page }
end
