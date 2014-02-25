class Api::V1::CommentsController < ApplicationController
  # GET /api/v1/comments
  # GET /api/v1/comments.json
  def index
    @api_v1_comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @api_v1_comments }
    end
  end

  # GET /api/v1/comments/1
  # GET /api/v1/comments/1.json
  def show
    @api_v1_comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @api_v1_comment }
    end
  end

  # GET /api/v1/comments/new
  # GET /api/v1/comments/new.json
  def new
    @api_v1_comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @api_v1_comment }
    end
  end

  # GET /api/v1/comments/1/edit
  def edit
    @api_v1_comment = Comment.find(params[:id])
  end

  # POST /api/v1/comments
  # POST /api/v1/comments.json
  def create
    @api_v1_comment = Comment.new(params[:api_v1_comment])

    respond_to do |format|
      if @api_v1_comment.save
        format.html { redirect_to @api_v1_comment, notice: 'Comment was successfully created.' }
        format.json { render json: @api_v1_comment, status: :created, location: @api_v1_comment }
      else
        format.html { render action: "new" }
        format.json { render json: @api_v1_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /api/v1/comments/1
  # PUT /api/v1/comments/1.json
  def update
    @api_v1_comment = Comment.find(params[:id])

    respond_to do |format|
      if @api_v1_comment.update_attributes(params[:api_v1_comment])
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
    @api_v1_comment = Comment.find(params[:id])
    @api_v1_comment.destroy

    respond_to do |format|
      format.html { redirect_to api_v1_comments_url }
      format.json { head :no_content }
    end
  end
end
