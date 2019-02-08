class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_commentable
  before_action :set_comment, only: %i(reply edit update destroy)
  load_and_authorize_resource :comment, param_method: :comment_params

  def reply
    @reply = @commentable.comments.build(parent: @comment)
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.json { render json: @comment }
        format.js
      else
        format.json { render json: @comment.errors }
        format.js
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.json { render json: @comment }
        format.js
      else
        format.json { render json: @comment.errors }
        format.js
      end
    end
  end

  def destroy
    @comment.destroy if @comment.errors.empty?
    respond_to do |format|
      format.json { head :no_content }
      format.js
    end
  end

  private

  def set_commentable
    resource, id = request.path.split('/')[1,2]
    @commentable = resource.singularize.classify.constantize.friendly.find(id)
  end

  def set_comment
    begin
      @comment = @commentable.comments.joins(:user).find(params[:id])
    rescue 
      @comment = @commentable.comments.build
      redirect_to posts_path, notice: 'Post not found'
      #@comment.errors.add(:base, :recordnotfound, message: "That record doesn't exist. Maybe, it is already destroyed.")
    end
  end

  def comment_params
    params.require(:comment).permit(:content, :parent_id)
  end
end
