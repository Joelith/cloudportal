require 'rails_helper'
require 'pp'
RSpec.describe CloudProvisionerJob, type: :job do
  
  it 'provisions cloud instances' do
    product = FactoryGirl.create(:product, name: 'Bronze Database')
    FactoryGirl.create(:oracle_db, product: product)
    environment = FactoryGirl.create(:environment)
    instances = environment.cloud_instances

    expect{ CloudProvisionerJob.perform_now(instances) }.
        to change { instances[0].status }.from('PENDING').to('PROVISIONED')
  end

end
