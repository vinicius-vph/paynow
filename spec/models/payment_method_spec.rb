require 'rails_helper'

RSpec.describe PaymentMethod, type: :model do
  describe '- Payment Method uniqueness validation' do
    it { should validate_uniqueness_of(:name).with_message('já está em uso') }
  end

  describe '- Payment Method validates presence of parameters' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:payment_fee) }
    it { should validate_presence_of(:max_pay_fee) }
    it { should validate_presence_of(:payment_type) }
  end
  
  describe '- Payment Method minimum value validation' do
    it { should validate_numericality_of(:payment_fee).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:max_pay_fee).is_greater_than_or_equal_to(0) }  
  end
end
