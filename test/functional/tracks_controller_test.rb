require 'test_helper'

class TracksControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tracks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create track" do
    assert_difference('Track.count') do
      post :create, :track => { }
    end

    assert_redirected_to track_path(assigns(:track))
  end

  test "should show track" do
    get :show, :id => tracks(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => tracks(:one).to_param
    assert_response :success
  end

  test "should update track" do
    put :update, :id => tracks(:one).to_param, :track => { }
    assert_redirected_to track_path(assigns(:track))
  end

  test "should destroy track" do
    assert_difference('Track.count', -1) do
      delete :destroy, :id => tracks(:one).to_param
    end

    assert_redirected_to tracks_path
  end
end
