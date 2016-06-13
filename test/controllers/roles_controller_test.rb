require "test_helper"

class RolesControllerTest < ActionController::TestCase
  def role
    @role ||= roles :one
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:roles)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference("Role.count") do
      post :create, role: { title: role.title }
    end

    assert_redirected_to role_path(assigns(:role))
  end

  def test_show
    get :show, id: role
    assert_response :success
  end

  def test_edit
    get :edit, id: role
    assert_response :success
  end

  def test_update
    put :update, id: role, role: { title: role.title }
    assert_redirected_to role_path(assigns(:role))
  end

  def test_destroy
    assert_difference("Role.count", -1) do
      delete :destroy, id: role
    end

    assert_redirected_to roles_path
  end
end
