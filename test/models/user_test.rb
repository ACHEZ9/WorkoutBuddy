require 'test_setup'

class UserTest < ActionController::Test
  # test "the truth" do
  #   assert true
  # end
  setup do
    @user = users(:one)
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { avatar: @user.avatar, bio: @user.bio, email: "unique@email.com", name: @user.name, password: "Test", password_confirmation: "Test"}
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "users should access events"

end
