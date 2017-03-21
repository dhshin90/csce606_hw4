require 'rails_helper.rb'

describe Movie do
  it 'should return all ratings' do
    Movie.all_ratings.should eq(["G", "PG", "PG-13", "NC-17", "R"])
  end
end