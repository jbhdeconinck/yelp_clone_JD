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
    let(:user1) do
      user1 = User.create(email: 'hello@hello.com',
                          password: 'password1',
                          password_confirmation: 'password1')
    end

    let(:user2) do
      user2 = User.create(email: 'hola@hello.com',
                          password: 'password2',
                          password_confirmation: 'password2')
    end

      it 'returns the average rating' do
        restaurant = Restaurant.create(name: 'The Ivy')
        review1 = restaurant.reviews.create(rating: 5)
        user1.reviews << review1
        review2 = restaurant.reviews.create(rating: 1)
        user2.reviews << review2
        expect(restaurant.average_rating).to eq 3
      end
    end
  end
end
