require 'test_helper'

class Api::V2::PostsControllerTest < ActionController::TestCase
  setup do
    @api_v2_post = api_v2_posts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_v2_posts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create api_v2_post" do
    assert_difference('Api::V2::Post.count') do
      post :create, api_v2_post: { content: @api_v2_post.content, user_id: @api_v2_post.user_id }
    end

    assert_redirected_to api_v2_post_path(assigns(:api_v2_post))
  end

  test "should show api_v2_post" do
    get :show, id: @api_v2_post
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @api_v2_post
    assert_response :success
  end

  test "should update api_v2_post" do
    put :update, id: @api_v2_post, api_v2_post: { content: @api_v2_post.content, user_id: @api_v2_post.user_id }
    assert_redirected_to api_v2_post_path(assigns(:api_v2_post))
  end

  test "should destroy api_v2_post" do
    assert_difference('Api::V2::Post.count', -1) do
      delete :destroy, id: @api_v2_post
    end

    assert_redirected_to api_v2_posts_path
  end
end
