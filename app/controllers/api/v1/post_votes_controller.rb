class Api::V1::PostVotesController < ApplicationController

# here inheriting from the original Post vote, and adding the old model code here for api 1, and keep the model up to date with the new changes.
#only used with api1
class PostVote < ::PostVote
    def as_json(options={})
        super
        #super.merge(released_on: released_at.to_date)
    end
end

# GET /api/v1/post_votes
  # GET /api/v1/post_votes.json
  def index
    @api_v1_post_votes = PostVote.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @api_v1_post_votes }
    end
  end

  # GET /api/v1/post_votes/1
  # GET /api/v1/post_votes/1.json
  def show
    @api_v1_post_vote = PostVote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @api_v1_post_vote }
    end
  end

  # GET /api/v1/post_votes/new
  # GET /api/v1/post_votes/new.json
  def new
    @api_v1_post_vote = PostVote.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @api_v1_post_vote }
    end
  end

  # GET /api/v1/post_votes/1/edit
  def edit
    @api_v1_post_vote = PostVote.find(params[:id])
  end

  # POST /api/v1/post_votes
  # POST /api/v1/post_votes.json
  #creates if doesn't exist, otherwise updates.
  def create
      if(Post.find(params[:post_vote][:post_id]).user_id != params[:post_vote][:user_id]) # only vote if it's not the same user who wrote the post!
          @api_v1_post_vote=PostVote.find_by_post_id_and_user_id(params[:post_vote][:post_id], params[:post_vote][:user_id])
          if @api_v1_post_vote.nil?
              @api_v1_post_vote = PostVote.new(params[:post_vote])
          else
              @api_v1_post_vote.vote = params[:post_vote][:vote]
          end

        respond_to do |format|
            if @api_v1_post_vote.save
          #format.html { redirect_to @api_v1_post_vote, notice: 'Post vote was successfully created.' }
                format.json { render json: @api_v1_post_vote, status: :created }
            else
      #        format.html { render action: "new" }
                format.json { render json: @api_v1_post_vote.errors.messages.values, status: 400 }
            end
        end
      else
        render json: "Can't vote for yourself.", status: 400
      end
  end

  # PUT /api/v1/post_votes/1
  # PUT /api/v1/post_votes/1.json
  def update
    @api_v1_post_vote = PostVote.find(params[:id])

    respond_to do |format|
      if @api_v1_post_vote.update_attributes(params[:api_v1_post_vote])
        format.html { redirect_to @api_v1_post_vote, notice: 'Post vote was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @api_v1_post_vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/v1/post_votes/1
  # DELETE /api/v1/post_votes/1.json
  def destroy
    @api_v1_post_vote = PostVote.find(params[:id])
    @api_v1_post_vote.destroy

    respond_to do |format|
      format.html { redirect_to api_v1_post_votes_url }
      format.json { head :no_content }
    end
  end
end
