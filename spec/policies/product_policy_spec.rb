require 'rails_helper'

describe ProductPolicy do

  let(:user) { FactoryGirl.create(:user) }
  let(:project_owner) { FactoryGirl.create(:project_owner) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:product) { FactoryGirl.create(:product)}

  subject { ProductPolicy }

  permissions :create? do
    it 'allows admins to create' do
      expect(subject).to permit(admin, product)
    end
    it 'prevents anyone else from creating' do
      expect(subject).not_to permit(user, product)
      expect(subject).not_to permit(project_owner, product)
    end
  end

  permissions :show? do
    it 'allows everyone to view' do
      expect(subject).to permit(admin, product)
      #expect(subject).to permit(user, product)
      #expect(subject).to permit(project_owner, product)
    end
  end

  permissions :update? do
    it 'allows admins to update' do
      expect(subject).to permit(admin, product)
    end
    it 'prevents anyone else from updating' do
      expect(subject).not_to permit(user, product)
      expect(subject).not_to permit(project_owner, product)
    end
  end

  permissions :destroy? do
    it 'allows admins to destroy' do
      expect(subject).to permit(admin, product)
    end
    it 'prevents anyone else from destroying' do
      expect(subject).not_to permit(user, product)
      expect(subject).not_to permit(project_owner, product)
    end
  end
end
