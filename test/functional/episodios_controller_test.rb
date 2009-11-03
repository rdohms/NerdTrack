require 'test_helper'

class EpisodiosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:episodios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create episodio" do
    assert_difference('Episodio.count') do
      post :create, :episodio => { }
    end

    assert_redirected_to episodio_path(assigns(:episodio))
  end

  test "should show episodio" do
    get :show, :id => episodios(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => episodios(:one).to_param
    assert_response :success
  end

  test "should update episodio" do
    put :update, :id => episodios(:one).to_param, :episodio => { }
    assert_redirected_to episodio_path(assigns(:episodio))
  end

  test "should destroy episodio" do
    assert_difference('Episodio.count', -1) do
      delete :destroy, :id => episodios(:one).to_param
    end

    assert_redirected_to episodios_path
  end
end
