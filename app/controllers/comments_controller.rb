class CommentsController < ApplicationController

  before_filter :find_resource

  def index
    @comments = current_user.comments.by_latest
  end

  def show
  end

  def new
  end

  def create
    @comment.comment = params[:comment][:comment]
    @comment.user = current_user
    @comment.receiver_user_id = @commentable.user_id
    @comment.save

    send_to = @commentable.comments.map(&:user)
    send_to << @comment.commentable.user

    send_to.uniq.reject{ |u| u == current_user }.each do |u|
      CommentMailer.reply_email(@comment, u).deliver
    end

    if params[:back] == 'back'
      redirect_to :back , :notice  => "Successfully added comment."
    else
      redirect_to @commentable, :notice  => "Successfully added comment."
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def find_resource
    @commentable = case
      when params.has_key?(:plan_id) then
        Plan.find(params[:plan_id])
      when params.has_key?(:achievement_id) then
        Achievement.find(params[:achievement_id])
    end

    case params[:action]
      when 'new'
        @comment = Comment.new
      when 'create'
        @comment = @commentable.comments.create
      when 'show', 'edit', 'update', 'destroy'
        @comment = @commentable.find(params[:id])
    end
  end
end
