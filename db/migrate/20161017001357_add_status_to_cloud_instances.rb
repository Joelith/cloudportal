class AddStatusToCloudInstances < ActiveRecord::Migration[5.0]
  def change
    add_column :cloud_instances, :status, :string
  end
end
