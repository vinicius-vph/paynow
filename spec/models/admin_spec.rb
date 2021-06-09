require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe '- Login validations'do
    subject {Admin.new(email: 'admin_one@paynow.com.br', password: '123mudar')}
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should_not validate_uniqueness_of(:email) }
  end

  describe '- Email domain pattern' do
    subject {Admin.new(email: "admin_one@paylater.com.br", password: '123mudar')}
    it { should allow_value("admin_one@paynow.com.br").for(:email)}
    it { should_not allow_value(subject.email).for(:email)}
  end

end
