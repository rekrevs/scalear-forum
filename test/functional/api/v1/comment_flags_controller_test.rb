require 'test_helper'

class Api::V1::CommentFlagsControllerTest < ActionController::TestCase
  setup do
    @api_v1_comment_flag = api_v1_comment_flags(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_v1_comment_flags)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create api_v1_comment_flag" do
    assert_difference('Api::V1::CommentFlag.count') do
      post :create, api_v1_comment_flag: { comment_id: @api_v1_comment_flag.comment_id, user_id: @api_v1_comment_flag.user_id }
    end

    assert_redirected_to api_v1_comment_flag_path(assigns(:api_v1_comment_flag))
  end

  test "should show api_v1_comment_flag" do
    get :show, id: @api_v1_comment_flag
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @api_v1_comment_flag
    assert_response :success
  end

  test "should update api_v1_comment_flag" do
    put :update, id: @api_v1_comment_flag, api_v1_comment_flag: { comment_id: @api_v1_comment_flag.comment_id, user_id: @api_v1_comment_flag.user_id }
    assert_redirected_to api_v1_comment_flag_path(assigns(:api_v1_comment_flag))
  end

  test "should destroy api_v1_comment_flag" do
    assert_difference('Api::V1::CommentFlag.count', -1) do
      delete :destroy, id: @api_v1_comment_flag
    end

    assert_redirected_to api_v1_comment_flags_path
  end
end
