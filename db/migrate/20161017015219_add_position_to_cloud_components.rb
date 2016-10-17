class AddPositionToCloudComponents < ActiveRecord::Migration[5.0]
  def change
    add_column :cloud_components, :position, :integer
  end
end
