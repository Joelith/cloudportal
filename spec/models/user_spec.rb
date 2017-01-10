require 'rails_helper'

RSpec.describe User, type: :model do
	it 'is valid with valid attributes' do
		expect(User.new(email: 'test@test.com', password: 'password123')).to be_valid
	end
end
