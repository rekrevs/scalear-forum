require 'test_helper'

class Api::V1::CommentsControllerTest < ActionController::TestCase
  setup do
    @api_v1_comment = api_v1_comments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_v1_comments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create api_v1_comment" do
    assert_difference('Api::V1::Comment.count') do
      post :create, api_v1_comment: { content: @api_v1_comment.content, post_id: @api_v1_comment.post_id, user_id: @api_v1_comment.user_id }
    end

    assert_redirected_to api_v1_comment_path(assigns(:api_v1_comment))
  end

  test "should show api_v1_comment" do
    get :show, id: @api_v1_comment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @api_v1_comment
    assert_response :success
  end

  test "should update api_v1_comment" do
    put :update, id: @api_v1_comment, api_v1_comment: { content: @api_v1_comment.content, post_id: @api_v1_comment.post_id, user_id: @api_v1_comment.user_id }
    assert_redirected_to api_v1_comment_path(assigns(:api_v1_comment))
  end

  test "should destroy api_v1_comment" do
    assert_difference('Api::V1::Comment.count', -1) do
      delete :destroy, id: @api_v1_comment
    end

    assert_redirected_to api_v1_comments_path
  end
end
