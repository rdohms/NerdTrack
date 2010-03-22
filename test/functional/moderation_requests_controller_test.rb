require 'test_helper'

class ModerationRequestsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:moderation_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create moderation_request" do
    assert_difference('ModerationRequest.count') do
      post :create, :moderation_request => { }
    end

    assert_redirected_to moderation_request_path(assigns(:moderation_request))
  end

  test "should show moderation_request" do
    get :show, :id => moderation_requests(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => moderation_requests(:one).to_param
    assert_response :success
  end

  test "should update moderation_request" do
    put :update, :id => moderation_requests(:one).to_param, :moderation_request => { }
    assert_redirected_to moderation_request_path(assigns(:moderation_request))
  end

  test "should destroy moderation_request" do
    assert_difference('ModerationRequest.count', -1) do
      delete :destroy, :id => moderation_requests(:one).to_param
    end

    assert_redirected_to moderation_requests_path
  end
end
