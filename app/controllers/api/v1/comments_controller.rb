class Api::V1::CommentsController < ApplicationController
    
  before_filter :load_parent
  # GET /api/v1/comments
  # GET /api/v1/comments.json
  def index
      puts "params areeee"
      puts params
    @api_v1_comments = @post.comments.all
    @api_v1_comments.each do |a|
        a.current_user_id = params[:user_id]
    end

    respond_to do |format|
      format.json { render json: @api_v1_comments.to_json(:methods => [:votes_count, :user_vote, :user_flag]) }
    end
  end

  # GET /api/v1/comments/1
  # GET /api/v1/comments/1.json
  def show
    @api_v1_comment = @post.comments.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @api_v1_comment }
    end
  end

  # GET /api/v1/comments/new
  # GET /api/v1/comments/new.json
  def new
    @api_v1_comment = @post.comments.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @api_v1_comment }
    end
  end

  # GET /api/v1/comments/1/edit
  def edit
    @api_v1_comment = @post.comments.find(params[:id])
  end

  # POST /api/v1/comments
  # POST /api/v1/comments.json
  def create
    @api_v1_comment = @post.comments.new(params[:comment])
    if @api_v1_comment.save
        render :json => @api_v1_comment.to_json(:methods => [:votes_count, :user_vote, :user_flag])
    else
        render :json => @api_v1_comment.errors.to_json, :status => 400
    end
  end

  # PUT /api/v1/comments/1
  # PUT /api/v1/comments/1.json
  def update
    @api_v1_comment = @post.comments.find(params[:id])

    respond_to do |format|
      if @api_v1_comment.update_attributes(params[:comment])
        format.html { redirect_to @api_v1_comment, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @api_v1_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/v1/comments/1
  # DELETE /api/v1/comments/1.json
  def destroy
    @api_v1_comment = @post.comments.find(params[:id])
    if @api_v1_comment.user_id == params[:current_user_id].to_i  #can only delete my comment
        @api_v1_comment.destroy
    end

#respond_to do |format|
#      format.html { redirect_to api_v1_comments_url }
#      format.json { head :no_content }
#    end
      render :json => {}
  end
  
  
  
  private
  
  def load_parent
      @post = Post.find(params[:post_id])
   end
end
