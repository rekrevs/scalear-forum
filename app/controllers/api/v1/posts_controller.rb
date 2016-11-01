class Api::V1::PostsController < ApplicationController
  # GET /api/v1/posts
  # GET /api/v1/posts.json
  def index
      if(!params[:privacy]) #want all
          @api_v1_posts = Post.includes(:post_votes).where(:lecture_id => params[:lecture_id])
      else #only public and mine
        @api_v1_posts = Post.includes(:post_votes, :post_flags).where(:lecture_id => params[:lecture_id], :user_id =>        params[:user_id]) #all mine
        @api_v1_posts << Post.includes(:post_votes,:post_flags).where("lecture_id = ? and user_id != ? and privacy = ?",params[:lecture_id],params[:user_id], params[:privacy])
        @api_v1_posts.flatten!
      end

      @api_v1_posts.each do |a|
          a.current_user_id = params[:user_id]
      end

    respond_to do |format|
        format.json { render json: @api_v1_posts.to_json(:methods => [:votes_count, :user_vote, :user_flag, :flags_count]) }
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
        render :json => post.to_json(:methods => [:votes_count, :user_vote, :user_flag, :flags_count])
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
    params[:post].delete :created_at
    params[:post].delete :updated_at
    respond_to do |format|
      if @api_v1_post.update_attributes(params[:post])
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
    #if @api_v1_post.user_id == params[:current_user_id].to_i  #can only delete my post
        @api_v1_post.destroy
    #end

#respond_to do |format|
#     format.html { redirect_to api_v1_posts_url }
#     format.json { head :no_content }
#   end
    render :json => {}
  end

  def count
    render :json => Post.count
  end

  def where
    render :json => Post.where(params[:query])
  end

  def column_names
    render :json => Post.column_names
  end

  def destroy_all_by_user
    Post.destroy_all(:user_id => params[:user_id], :lecture_id => params[:lecture_id])
    render :json => {}
  end

  def destroy_all_by_lecture
    Post.destroy_all(:lecture_id => params[:lecture_id])
    render :json => {}
  end

  def posts_count
    start_date = DateTime.parse(params[:start_date]).midnight
    end_date = DateTime.parse(params[:end_date]).tomorrow
    posts ={}
    posts['courses'] ={}
    posts['total_questions'] = 0
    # posts['total_questions_students'] = 0
    # posts['total_questions_courses'] = 0
    # posts['total_questions_lectures'] = 0
    posts['ids'] = {}

    if params[:course_ids]
      post = Post.includes(:comments).select { |e| (params[:course_ids].include?(e.course_id.to_s)) && (e.updated_at.between?(start_date,end_date) || e.comments.select{|c| c.updated_at.between?(start_date,end_date)}.size != 0) } 
      # post = Post.includes(:comments).where("updated_at between ? and ? OR comments.updated_at between ? and ?", start_date , end_date, start_date , end_date)
      courses = post.map { |p| p.course_id }.uniq
      courses.each do |course_id|
        posts['courses'][course_id] = post.select{|p| p.course_id == course_id}.size
      end
      posts['total_questions'] = post.count
      # posts['total_questions_students'] = post.map { |p| p.user_id }.uniq.count
      # posts['total_questions_courses'] = courses.count
      # posts['total_questions_lectures'] = post.map { |p| p.lecture_id }.uniq.count

      
      posts['ids'] = Comment.includes(:post).find_all_by_post_id( post.map {|p|p.id} ).map { |c| {"user_id" => c.user_id ,"course_id" => c.post.course_id}}.group_by{|c| c["course_id"]}
    end
    # posts['courses'] = courses
    # group_posts_by_course = created_lec_views.includes([:lecture]).group('lecture_id').select('lecture_id ,course_id , (SUM(percent)) as percent ')

    render :json => posts
  end

  def updated_post_course_group_ids
# updated_post_course_group_id_without_updated at
    Post.find_all_by_lecture_id(params[:lecture_id]).each do |post|
       post.update_column(:course_id, params[:course_id])
       post.update_column(:group_id, params[:group_id])
    end
    render :json => "ok"

  end

end
