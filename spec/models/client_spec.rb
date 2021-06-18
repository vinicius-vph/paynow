require 'rails_helper'

RSpec.describe Client, type: :model do
  xdescribe '- Client email pattern validation' do
    it { should allow_value("admin@codeplay.com.br").for(:email) }
    it { should_not allow_value("admin@yahoo.com").for(:email).with_message('não é válido') }
    it { should_not allow_value("admin@hotmail.com").for(:email).with_message('não é válido') }
    it { should_not allow_value("admin@google.com").for(:email).with_message('não é válido') }
    it { should_not allow_value("admin@paynow.com").for(:email).with_message('não é válido') }
  end

  xdescribe '- Client presence validation' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
  end
end