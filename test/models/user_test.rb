require File.expand_path("../../test_helper", __FILE__)

class UserTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @user = users(:one)
  end

  test "is user valid?" do
    assert @user.valid?
  end
end
