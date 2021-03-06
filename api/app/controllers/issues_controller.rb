class IssuesController < ApplicationController
  def new
  end

  def create
    issue = Issue.create(params["issue"])
    render json: issue
  end

  def show
    @issue = Issue.find(params["id"])
    render
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
  
  def fix
    # TODO clean variables, control save action
    issue = Issue.find(params["id"])
    issue.fixed += 1
    issue.save
    redirect_to issue
  end
  
  def unfix
    issue = Issue.find(params["id"])
    issue.fixed -= 1
    issue.save
    redirect_to issue
  end

end
