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
end
