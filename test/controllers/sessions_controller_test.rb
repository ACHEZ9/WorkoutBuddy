require File.expand_path("../../test_helper", __FILE__)

class SessionsControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
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

  test "Should reject incorrect username " do
    post :create, session:{email: 'fail', password: 'deis'}
    assert_redirected_to login_path
  end

  test "Should accept username in all caps" do
    post :create, session:{email: @user.email.upcase, password: 'deis'}
    assert_redirected_to @user
  end

  test "Should reject password in all caps" do
    post :create, session:{email: @user.email.upcase, password: 'deis'.upcase}
    assert_redirected_to login_path
  end

end
