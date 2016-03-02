require 'minitest/autorun'

class User < Minitest::Test
  # test "the truth" do
  #   assert true
  # end

  let(:user_setup){ { name: "Dave", email: "dave@gmail.com", bio: "what's up", password: "12345678"} }

  it "is valid with valid parameters" do
    user = User.new setup

    user.must_be :valid?
  end

  it "is invalid without name" do
    parameters = setup.clone
    parameters.delete :name
    user = User.new parameters

    user.wont_be :valid?
    user.errors[:name].must_be :present?
  end

  it "can log in" do

  end
end
