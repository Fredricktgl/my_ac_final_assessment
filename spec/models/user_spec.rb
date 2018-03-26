require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }

  it 'should validate email uniqueness' do 
    user = User.new(
      name: "Test",
      email: "test@gmail.com",
      password: "123123123"

    )
    expect(user).to validate_uniqueness_of(:email).case_insensitive
  
  end
end
