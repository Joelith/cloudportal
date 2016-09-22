class ComputeInstance < CloudModelBase
  attr_accessor :name

  validates :name, :presence => true

  def self.all
    compute.instances
  end

  def self.find_by_id(id)
    compute.instances.get(id)
  end

  def self.create(params)
    compute.instances.create(:name => params[:name])
  end

  def self.delete(id)
    compute.instances.get(id).destroy
  end
end