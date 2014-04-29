class Api::V1::CommentFlagsController < ApplicationController
  # GET /api/v1/comment_flags
  # GET /api/v1/comment_flags.json
  def index
    @api_v1_comment_flags = CommentFlag.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @api_v1_comment_flags }
    end
  end

  # GET /api/v1/comment_flags/1
  # GET /api/v1/comment_flags/1.json
  def show
    @api_v1_comment_flag = CommentFlag.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @api_v1_comment_flag }
    end
  end

  # GET /api/v1/comment_flags/new
  # GET /api/v1/comment_flags/new.json
  def new
    @api_v1_comment_flag = CommentFlag.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @api_v1_comment_flag }
    end
  end

  # GET /api/v1/comment_flags/1/edit
  def edit
    @api_v1_comment_flag = CommentFlag.find(params[:id])
  end

  # POST /api/v1/comment_flags
  # POST /api/v1/comment_flags.json
  def create
    if(Comment.find(params[:comment_flag][:comment_id]).user_id.to_i != params[:comment_flag][:user_id].to_i) # only flag if it's not the same user who wrote the comment!
      @api_v1_comment_flag=CommentFlag.find_by_comment_id_and_user_id(params[:comment_flag][:comment_id], params[:comment_flag][:user_id])
      if @api_v1_comment_flag.nil?
          @api_v1_comment_flag = CommentFlag.new(params[:comment_flag])
          respond_to do |format|
              if @api_v1_comment_flag.save
                  #format.html { redirect_to @api_v1_post_vote, notice: 'Post vote was successfully created.' }
                  format.json { render json: @api_v1_comment_flag, status: :created }
                  else
                  
                  format.json { render json: @api_v1_comment_flag.errors.messages.values, status: 400 }
              end
          end
          else
          @api_v1_comment_flag.destroy
          render json: {}
      end
      else
         render json: "Can't flag yourself.", status: 400
      end
  end

  # PUT /api/v1/comment_flags/1
  # PUT /api/v1/comment_flags/1.json
  def update
    @api_v1_comment_flag = CommentFlag.find(params[:id])

    respond_to do |format|
      if @api_v1_comment_flag.update_attributes(params[:comment_flag])
        format.html { redirect_to @api_v1_comment_flag, notice: 'Comment flag was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @api_v1_comment_flag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/v1/comment_flags/1
  # DELETE /api/v1/comment_flags/1.json
  def destroy
    # @api_v1_comment_flag = CommentFlag.find(params[:id])
    # @api_v1_comment_flag.destroy

    # respond_to do |format|
    #   format.html { redirect_to api_v1_comment_flags_url }
    #   format.json { head :no_content }
    # end
    @api_v1_comment_flag = CommentFlag.where(:comment_id => params[:id])
    @api_v1_comment_flag.destroy_all
    render :json => {}
  end
end
