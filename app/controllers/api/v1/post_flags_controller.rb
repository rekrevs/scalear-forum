class Api::V1::PostFlagsController < ApplicationController
  # GET /api/v1/post_flags
  # GET /api/v1/post_flags.json
  def index
    @api_v1_post_flags = PostFlag.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @api_v1_post_flags }
    end
  end

  # GET /api/v1/post_flags/1
  # GET /api/v1/post_flags/1.json
  def show
    @api_v1_post_flag = PostFlag.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @api_v1_post_flag }
    end
  end

  # GET /api/v1/post_flags/new
  # GET /api/v1/post_flags/new.json
  def new
    @api_v1_post_flag = PostFlag.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @api_v1_post_flag }
    end
  end

  # GET /api/v1/post_flags/1/edit
  def edit
    @api_v1_post_flag = PostFlag.find(params[:id])
  end

  # POST /api/v1/post_flags
  # POST /api/v1/post_flags.json
  def create
      @api_v1_post_flag=PostFlag.find_by_post_id_and_user_id(params[:post_flag][:post_id], params[:post_flag][:user_id])
      if @api_v1_post_flag.nil?
          @api_v1_post_flag = PostFlag.new(params[:post_flag])
          respond_to do |format|
              if @api_v1_post_flag.save
                  #format.html { redirect_to @api_v1_post_vote, notice: 'Post vote was successfully created.' }
                  format.json { render json: @api_v1_post_flag, status: :created }
                  else
                  
                  format.json { render json: @api_v1_post_flag.errors.messages.values, status: 400 }
              end
          end
      else
          @api_v1_post_flag.destroy
          render json: {:msg => "destroyed"}
      end
  end

  # PUT /api/v1/post_flags/1
  # PUT /api/v1/post_flags/1.json
  def update
    @api_v1_post_flag = PostFlag.find(params[:id])

    respond_to do |format|
      if @api_v1_post_flag.update_attributes(params[:api_v1_post_flag])
        format.html { redirect_to @api_v1_post_flag, notice: 'Post flag was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @api_v1_post_flag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/v1/post_flags/1
  # DELETE /api/v1/post_flags/1.json
  def destroy
    @api_v1_post_flag = PostFlag.find(params[:id])
    @api_v1_post_flag.destroy

    respond_to do |format|
      format.html { redirect_to api_v1_post_flags_url }
      format.json { head :no_content }
    end
  end
end
