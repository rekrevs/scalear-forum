class Api::V1::PostsController < ApplicationController
  # GET /api/v1/posts
  # GET /api/v1/posts.json
  def index
      if(!params[:privacy]) #want all
          @api_v1_posts = Post.includes(:post_votes).where(:lecture_id => params[:lecture_id])
      else #only public and mine
        @api_v1_posts = Post.includes(:post_votes).where(:lecture_id => params[:lecture_id], :user_id =>        params[:user_id]) #all mine
        @api_v1_posts << Post.includes(:post_votes).where("lecture_id = ? and user_id != ? and privacy = ?",params[:lecture_id],params[:user_id], params[:privacy])
        @api_v1_posts.flatten!
      end

      @api_v1_posts.each do |a|
          a.current_user_id = params[:user_id]
      end

    respond_to do |format|
        format.json { render json: @api_v1_posts.to_json(:methods => [:votes_count, :user_vote, :user_flag]) }
    end
  end

  # GET /api/v1/posts/1
  # GET /api/v1/posts/1.json
  def show
    @api_v1_post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @api_v1_post }
    end
  end

  # GET /api/v1/posts/new
  # GET /api/v1/posts/new.json
  def new
    @api_v1_post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @api_v1_post }
    end
  end

  # GET /api/v1/posts/1/edit
  def edit
    @api_v1_post = Post.find(params[:id])
  end

  # POST /api/v1/posts
  # POST /api/v1/posts.json
  #def create
  #  @api_v1_post = Api::V1::Post.new(params[:api_v1_post])
  #
  #  respond_to do |format|
  #    if @api_v1_post.save
  #      format.html { redirect_to @api_v1_post, notice: 'Post was successfully created.' }
  #      format.json { render json: @api_v1_post, status: :created, location: @api_v1_post }
  #    else
  #      format.html { render action: "new" }
  #      format.json { render json: @api_v1_post.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end
  
  def create
    begin
      #json = JSON.parse(request.body.read)
      puts params[:post]
      #puts params[:user_id]
      #puts "json isssss"
      #puts json.inspect
      post = Post.create(params[:post] )
      if post.valid?
        render :json => post.to_json(:methods => [:votes_count, :user_vote, :user_flag])
      else
        render :json => post.errors.to_json, :status => 400
      end
    rescue => e
      puts e.message.inspect
      render :json => e.message.to_json, :status => 500
    end
  end
      

  # PUT /api/v1/posts/1
  # PUT /api/v1/posts/1.json
  def update
    @api_v1_post = Post.find(params[:id])

    respond_to do |format|
      if @api_v1_post.update_attributes(params[:api_v1_post])
        format.html { redirect_to @api_v1_post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @api_v1_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/v1/posts/1
  # DELETE /api/v1/posts/1.json
  def destroy
    @api_v1_post = Post.find(params[:id])
    if @api_v1_post.user_id == params[:current_user_id].to_i  #can only delete my post
        @api_v1_post.destroy
    end

#respond_to do |format|
#     format.html { redirect_to api_v1_posts_url }
#     format.json { head :no_content }
#   end
    render :json => {}
  end
end
