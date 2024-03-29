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
    if(Comment.find(params[:comment_vote][:comment_id]).user_id.to_i != params[:comment_vote][:user_id].to_i) # only vote if it's not the same user who wrote the comment!
      @api_v1_comment_vote=CommentVote.find_by_comment_id_and_user_id(params[:comment_vote][:comment_id], params[:comment_vote][:user_id])
      if @api_v1_comment_vote.nil?
          @api_v1_comment_vote = CommentVote.new(params[:comment_vote])
          else
          @api_v1_comment_vote.vote = params[:comment_vote][:vote]
      end
      
      respond_to do |format|
          if @api_v1_comment_vote.save
              #format.html { redirect_to @api_v1_post_vote, notice: 'Post vote was successfully created.' }
              format.json { render json: @api_v1_comment_vote, status: :created }
              else
              #        format.html { render action: "new" }
              format.json { render json: @api_v1_comment_vote.errors.messages.values, status: 400 }
          end
      end
     else
        render json: "Can't vote for yourself.", status: 400
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
