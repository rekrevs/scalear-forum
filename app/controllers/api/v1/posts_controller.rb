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
    posts ={'active_courses' => {},'total_courses' => {} ,'total_questions' => 0, 'comments_user_id'=> {}}

    if params[:course_ids]
      active_posts = Post.joins("left outer join comments on posts.id =comments.post_id").select("posts.id, comments.user_id cu, course_id").where("posts.course_id IN (?) AND (posts.updated_at between ? and ? OR comments.updated_at between ? and ?)", params[:course_ids], start_date, end_date, start_date, end_date).group_by{|f| f.course_id}
      total_posts = Post.where("posts.course_id IN (?)", params[:course_ids]).group('course_id').select('course_id , (COUNT(*)) as count').group_by(&:course_id)

      active_posts.each do |course_id,values|
        count = values.map(&:id).uniq.size
        comments_user_id = values.map(&:cu).uniq.select{|v| !v.nil?}
        posts['active_courses'][course_id] = count
        posts['total_courses'][course_id] =  total_posts[course_id][0].count.to_i
        posts['total_questions'] += count
        posts['comments_user_id'][course_id] =comments_user_id if comments_user_id.size > 0
      end
    end
    render :json => posts
  end

  def posts_unanswered_questions
    posts_total = Post.where(:group_id=>params[:group_id]).count
    posts_unanswered = Post.where(:group_id=>params[:group_id]).joins("left outer join comments on posts.id =comments.post_id").group('posts.id').having('count(comments.id) = 0')
    posts_total_unanswered = 0
    posts_unanswered.count.each{|post_lecture_count| posts_total_unanswered+=post_lecture_count[1].to_i}

    posts = posts_unanswered.select("posts.id, posts.content , posts.lecture_id ,posts.privacy").group_by{|c| c.lecture_id}
    render :json => {posts: posts , posts_total:posts_total , posts_total_unanswered:posts_total_unanswered }
  end

  def get_questions_replies
    if params[:user_id]
      raw_posts = Post.where(:group_id=>params[:group_id],:user_id=>params[:user_id])
    else
      raw_posts = Post.where(:group_id=>params[:group_id])
    end
    posts_total = raw_posts.count
    posts_answered = raw_posts.select{|a| a.comments.count != 0}.count
    # posts = {}
    posts = raw_posts.joins("left outer join comments on posts.id =comments.post_id").select("posts.group_id, posts.time,  posts.content AS post_content, posts.lecture_id AS lecture_id , posts.privacy AS privacy , comments.user_id AS user_id  , comments.content AS comment_content").group_by{|c| c.lecture_id}
    render :json => {posts: posts , posts_total:posts_total , posts_answered:posts_answered }
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
