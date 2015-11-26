require 'spec_helper'

describe Restaurant, type: :model do
  it { is_expected.to have_many :reviews }

  it {is_expected.to belong_to :user}

  it 'is not valid with a name of less than three characters' do
    restaurant = Restaurant.new(name: 'kf')
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it 'is not valid unless the name is unique' do
    restaurant = Restaurant.create(name: 'KFC')
    restaurant2 = Restaurant.new(name: 'KFC')
    expect(restaurant2).to have(1).error_on(:name)
  end

  describe '#average_rating' do
    context 'no reviews' do
      it 'returns "N/A" when there are no reviews' do
        restaurant = Restaurant.create(name: 'The Ivy')
        expect(restaurant.average_rating).to eq 'N/A'
      end
    end

    context 'has 1 review' do
      it 'return that rating' do
        restaurant = Restaurant.create(name: 'The Ivy')
        restaurant.reviews.create(rating: 4)
        expect(restaurant.average_rating).to eq 4
      end
    end

    context 'has 2 reviews' do
        let(:user) { FactoryGirl.build(:user) }
        let(:user2) { FactoryGirl.build(:user2) }
        let(:review_params) { { thoughts: 'So so', rating: 3 } }
        let(:review_params2) { { thoughts: 'Bad', rating: 1 } }

      it 'returns the average rating' do
        restaurant = Restaurant.create(name: 'The Ivy')
        restaurant.build_review(review_params, user)
        restaurant.save
        restaurant.build_review(review_params2, user2)
        restaurant.save
        expect(restaurant.average_rating).to eq 2
      end
    end
  end
end
