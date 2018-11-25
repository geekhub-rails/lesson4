class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { minimum: 3 }
  validates_length_of :password, minimum: 6, allow_blank: true

  has_secure_password validations: false

  has_many :user_connections, :foreign_key => :user_a_id, :dependent => :destroy
  has_many :users, :through => :user_connections, :source => :user_b
  has_many(:reverse_user_connections, :class_name => :UserConnection,
           :foreign_key => :user_b_id, :dependent => :destroy)
end
