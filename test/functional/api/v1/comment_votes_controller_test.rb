require 'test_helper'

class Api::V1::CommentVotesControllerTest < ActionController::TestCase
  setup do
    @api_v1_comment_vote = api_v1_comment_votes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_v1_comment_votes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create api_v1_comment_vote" do
    assert_difference('Api::V1::CommentVote.count') do
      post :create, api_v1_comment_vote: { comment_id: @api_v1_comment_vote.comment_id, user_id: @api_v1_comment_vote.user_id, vote: @api_v1_comment_vote.vote }
    end

    assert_redirected_to api_v1_comment_vote_path(assigns(:api_v1_comment_vote))
  end

  test "should show api_v1_comment_vote" do
    get :show, id: @api_v1_comment_vote
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @api_v1_comment_vote
    assert_response :success
  end

  test "should update api_v1_comment_vote" do
    put :update, id: @api_v1_comment_vote, api_v1_comment_vote: { comment_id: @api_v1_comment_vote.comment_id, user_id: @api_v1_comment_vote.user_id, vote: @api_v1_comment_vote.vote }
    assert_redirected_to api_v1_comment_vote_path(assigns(:api_v1_comment_vote))
  end

  test "should destroy api_v1_comment_vote" do
    assert_difference('Api::V1::CommentVote.count', -1) do
      delete :destroy, id: @api_v1_comment_vote
    end

    assert_redirected_to api_v1_comment_votes_path
  end
end
