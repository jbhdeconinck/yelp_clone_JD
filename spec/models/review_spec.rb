require 'spec_helper'

describe Review, type: :model do
  it { is_expected.to belong_to :restaurant }

  it 'is not valid with a rating greater than 5' do
    restaurant = Restaurant.create(name: 'KFC')
    review = restaurant.reviews.create(thoughts: 'spectacular', rating: 6)
    expect(review).to have(1).error_on(:rating)
    expect(review).not_to be_valid
  end
end
