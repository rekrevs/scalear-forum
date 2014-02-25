class Api::V1::CommentVotesController < ApplicationController
  # GET /api/v1/comment_votes
  # GET /api/v1/comment_votes.json
  def index
    @api_v1_comment_votes = CommentVote.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @api_v1_comment_votes }
    end
  end

  # GET /api/v1/comment_votes/1
  # GET /api/v1/comment_votes/1.json
  def show
    @api_v1_comment_vote = CommentVote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @api_v1_comment_vote }
    end
  end

  # GET /api/v1/comment_votes/new
  # GET /api/v1/comment_votes/new.json
  def new
    @api_v1_comment_vote = CommentVote.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @api_v1_comment_vote }
    end
  end

  # GET /api/v1/comment_votes/1/edit
  def edit
    @api_v1_comment_vote = CommentVote.find(params[:id])
  end

  # POST /api/v1/comment_votes
  # POST /api/v1/comment_votes.json
  def create
    @api_v1_comment_vote = CommentVote.new(params[:api_v1_comment_vote])

    respond_to do |format|
      if @api_v1_comment_vote.save
        format.html { redirect_to @api_v1_comment_vote, notice: 'Comment vote was successfully created.' }
        format.json { render json: @api_v1_comment_vote, status: :created, location: @api_v1_comment_vote }
      else
        format.html { render action: "new" }
        format.json { render json: @api_v1_comment_vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /api/v1/comment_votes/1
  # PUT /api/v1/comment_votes/1.json
  def update
    @api_v1_comment_vote = CommentVote.find(params[:id])

    respond_to do |format|
      if @api_v1_comment_vote.update_attributes(params[:api_v1_comment_vote])
        format.html { redirect_to @api_v1_comment_vote, notice: 'Comment vote was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @api_v1_comment_vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/v1/comment_votes/1
  # DELETE /api/v1/comment_votes/1.json
  def destroy
    @api_v1_comment_vote = CommentVote.find(params[:id])
    @api_v1_comment_vote.destroy

    respond_to do |format|
      format.html { redirect_to api_v1_comment_votes_url }
      format.json { head :no_content }
    end
  end
end
