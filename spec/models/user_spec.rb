require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create(name: 'user1') }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end
end
