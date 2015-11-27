class Restaurant < ActiveRecord::Base

  validates :name, length: {minimum: 3}, uniqueness: true
  has_many :reviews, dependent: :destroy
  belongs_to :user
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => ""
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def average_rating
    return 'N/A' if reviews.none?
    reviews.inject(0) { |sum, n| sum + n.rating } / reviews.count
  end

  def build_review review_params, user
    review = reviews.new(review_params)
    review.user = user
    review
  end

end
