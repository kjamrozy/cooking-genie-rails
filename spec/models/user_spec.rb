require 'rails_helper'

RSpec.describe User, type: :model do
  ['abcd@sth',
   '@sth.com',
   '@',
   'sth@gmail.'].each do |email|
    it "should be invalid with #{email} as email" do
      expect(build(:user, email: email).valid?).to be_falsy
    end
  end

  let(:user) { build(:user) }

  it 'given valid email should be valid' do
    expect(user.valid?).to be_truthy
  end

  it 'should not be valid with blank name' do
    user.name = ''
    expect(user.valid?).to be_falsy
  end

  it 'should not be valid with blank surname' do
    user.surname = ''
    expect(user.valid?).to be_falsy
  end

  it 'should not be valid without email' do
    user.email = nil
    expect(user.valid?).to be_falsy
  end

  it 'should not be valid without password' do
    user.password = nil
    expect(user.valid?).to be_falsy
  end

  it "shouldn't be valid when password and password confirmation don't match" do
    user.password = 'not_really_that_random'
    user.password_confirmation = 'sth_not_really_that_random'
    expect(user.valid?).to be_falsy
  end

  it "shouldn't be valid with password shorter than 8 characters" do
    user.password = user.password_confirmation = 'abcdefg'
    expect(user.valid?).to be_falsy
  end

  it 'should be valid with valid 8 characters long password' do
    user.password = user.password_confirmation = 'abcdefgh'
    expect(user.valid?).to be_truthy
  end

  it "with password exceeding 32 should't be valid" do
    user.password = user.password_confirmation = 'a' * 33
    expect(user.valid?).to be_falsy
  end

  it 'with password 32 characters long should be valid' do
    user.password = user.password_confirmation = 'a' * 32
    expect(user.valid?).to be_truthy
  end

  it 'should be invalid with two equal emails' do
    create(:user, email: 'same@email.com')
    @user = User.new(attributes_for(:user, email: 'same@email.com'))
    expect(@user.valid?).to be_falsy
  end

  it 'should have admin field equal to false by default' do
    user.admin = nil
    user.save
    expect(user.admin).to be_falsy
  end
end
