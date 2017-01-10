require 'rails_helper'
require 'pp'
RSpec.describe CloudProvisionerJob, type: :job do
  
  it 'provisions cloud instances' do
    product = FactoryGirl.create(:product, name: 'Bronze Database')
    FactoryGirl.create(:component_oracle_db, product: product)
    environment = FactoryGirl.create(:environment_with_db)
    instances = environment.cloud_instances
    ids = instances.pluck(:id)
    expect{ CloudProvisionerJob.perform_now(ids) }.
        to change { instances.reload.first.status }.from('PENDING').to('PROVISIONED')
  end

  it 'provisions multiple cloud instances' do
    environment = FactoryGirl.create(:environment_with_db_and_java)
    instances = environment.cloud_instances
    ids = instances.pluck(:id)
    expect{ CloudProvisionerJob.perform_now(ids) }.
        to change { instances.reload.second.status }.from('PENDING').to('PROVISIONED')

  end

end
