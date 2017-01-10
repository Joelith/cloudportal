require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'is valid with valid attributes' do
		expect(Product.new(name:'Test')).to be_valid
	end
end
