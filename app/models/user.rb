class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :assign_default_role

  has_and_belongs_to_many :projects

  def assign_default_role
    self.add_role(:requestor) if self.roles.blank?
  end

  def to_label
    "#{email}"
  end
end
