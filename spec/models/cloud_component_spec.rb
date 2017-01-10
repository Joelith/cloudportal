require 'rails_helper'

RSpec.describe CloudComponent, type: :model do
  it 'is valid with valid attributes' do
		expect(CloudComponent.new(config: {example: 'Test'})).to be_valid
	end

end
