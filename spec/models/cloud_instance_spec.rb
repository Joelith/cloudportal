require 'rails_helper'

RSpec.describe CloudInstance, type: :model do
	it 'is valid with valid attributes' do
		expect(CloudInstance.new).to be_valid
	end
end
