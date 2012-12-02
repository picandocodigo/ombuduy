class TagsController < ApplicationController
  def new
  end

  def create
    issue = Tag.create(params["issue"])
    render json: issue
  end

  def show
    @tag = Tag.find(params["id"])
    Rails.logger.info @tag.issues
    render
  end

  def index
    render json: Tag.limit(20)
  end

  def edit
  end

  def update
    tag = Tag.update_attributes(params["tag"])
    render json: tag
  end

  def destroy
    render status: 405
  end
end
