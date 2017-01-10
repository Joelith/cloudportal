class AddJustificationToEnvironments < ActiveRecord::Migration[5.0]
  def change
    add_column :environments, :justification, :text
  end
end
