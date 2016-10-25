class CloudComponent < ApplicationRecord
  belongs_to :product
  validates_presence_of :config
  acts_as_list scope: :product

  serialize :config

end
