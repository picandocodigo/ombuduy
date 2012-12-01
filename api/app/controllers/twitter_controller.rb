class TwitterController < ApplicationController
  def new
    data = ActiveSupport::JSON.decode(params["_json"])
    if (user = User.where(twitter_user_id: data["user_id"])).first.nil?
      user = User.create(twitter_user_id: data["user_id"].to_i)
    end
    issue = Issue.new(
                      text: data["text"],
                      image_url: data["image_url"],
                      latitude: data["latitude"].to_f,
                      longitude: data["longitude"].to_f,
                      twitter_id: data["twitter_id"],
                      user_id: user.id
                      )

    unless params["hastags"].nil? 
      params["hashtags"].each do |hashtag|
        if (tag = Tag.where(title: tag).first).nil?
          tag = Tag.create(title: tag)
        end
        issue.add_tag(tag)
      end
    end

    if issue.save
      render json: "/issues/#{issue.id}", status: 201
    else
      render status: 400
    end
  end

  def reply
    issue = Issue.where(twitter_id: "reply_to_id").first
    reply = Reply.new()
  end

  def rt
  end
end
