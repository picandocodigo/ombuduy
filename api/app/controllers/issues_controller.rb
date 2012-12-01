class IssuesController < ApplicationController
  def new
  end

  def create
    issue = Issue.create(params["issue"])
    render json: issue
  end

  def show
    render json: Issue.find(params["id"])
  end

  def index
    render json: Issue.order(:relevance).limit(20)
  end

  def edit
  end

  def update
    issue = Issue.update_attributes(params["issue"])
    render json: issue
  end

  def destroy
    render status: 405
  end
end
