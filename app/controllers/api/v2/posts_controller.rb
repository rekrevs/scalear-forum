class Api::V2::PostsController < ApplicationController
  # GET /api/v2/posts
  # GET /api/v2/posts.json
  def index
    @api_v2_posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @api_v2_posts }
    end
  end

  # GET /api/v2/posts/1
  # GET /api/v2/posts/1.json
  def show
    @api_v2_post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @api_v2_post }
    end
  end

  # GET /api/v2/posts/new
  # GET /api/v2/posts/new.json
  def new
    @api_v2_post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @api_v2_post }
    end
  end

  # GET /api/v2/posts/1/edit
  def edit
    @api_v2_post = Post.find(params[:id])
  end

  # POST /api/v2/posts
  # POST /api/v2/posts.json
  def create
    @api_v2_post = Post.new(params[:api_v2_post])

    respond_to do |format|
      if @api_v2_post.save
        format.html { redirect_to @api_v2_post, notice: 'Post was successfully created.' }
        format.json { render json: @api_v2_post, status: :created, location: @api_v2_post }
      else
        format.html { render action: "new" }
        format.json { render json: @api_v2_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /api/v2/posts/1
  # PUT /api/v2/posts/1.json
  def update
    @api_v2_post = Post.find(params[:id])

    respond_to do |format|
      if @api_v2_post.update_attributes(params[:api_v2_post])
        format.html { redirect_to @api_v2_post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @api_v2_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/v2/posts/1
  # DELETE /api/v2/posts/1.json
  def destroy
    @api_v2_post = Post.find(params[:id])
    @api_v2_post.destroy

    respond_to do |format|
      format.html { redirect_to api_v2_posts_url }
      format.json { head :no_content }
    end
  end
end
