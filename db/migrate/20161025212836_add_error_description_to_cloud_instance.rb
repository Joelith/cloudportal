class AddErrorDescriptionToCloudInstance < ActiveRecord::Migration[5.0]
  def change
    add_column :cloud_instances, :error_description, :text
  end
end
