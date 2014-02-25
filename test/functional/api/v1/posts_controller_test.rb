require 'test_helper'

class Api::V1::PostsControllerTest < ActionController::TestCase
  setup do
    @api_v1_post = api_v1_posts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_v1_posts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create api_v1_post" do
    assert_difference('Api::V1::Post.count') do
      post :create, api_v1_post: { content: @api_v1_post.content, user_id: @api_v1_post.user_id }
    end

    assert_redirected_to api_v1_post_path(assigns(:api_v1_post))
  end

  test "should show api_v1_post" do
    get :show, id: @api_v1_post
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @api_v1_post
    assert_response :success
  end

  test "should update api_v1_post" do
    put :update, id: @api_v1_post, api_v1_post: { content: @api_v1_post.content, user_id: @api_v1_post.user_id }
    assert_redirected_to api_v1_post_path(assigns(:api_v1_post))
  end

  test "should destroy api_v1_post" do
    assert_difference('Api::V1::Post.count', -1) do
      delete :destroy, id: @api_v1_post
    end

    assert_redirected_to api_v1_posts_path
  end
end
