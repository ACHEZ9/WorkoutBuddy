require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "Should reject invalid user credentials" do
    post :create, session:{email: @user.email, password: "wrong"}
    assert_redirected_to login_path
  end

  test "Should accept correct user credentials" do
    post :create, session:{email: @user.email, password: 'deis'}
    assert_redirected_to @user
  end

  test "can logout" do
    delete :destroy
    assert_redirected_to root_url
  end

end
