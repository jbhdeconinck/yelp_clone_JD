class Review < ActiveRecord::Base
  validates :rating, inclusion: (1..5)
  belongs_to :restaurant
  belongs_to :user
  validates :user, uniqueness: { scope: :restaurant, message: "Restaurant already reviewed" }
  has_many :endorsements

end
