class TwitterController < ApplicationController
  def new
    if (user = User.where(twitter_user_id: params["user_id"]).first).nil?
      user = User.create(twitter_user_id: params["user_id"].to_i)
    end
    issue = Issue.new(
                      text: params["text"],
                      image_url: params["image_url"],
                      latitude: params["latitude"].to_f,
                      longitude: params["longitude"].to_f,
                      tweet_id: params["tweet_id"],
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
    unless (issue = give_relevance(params['reply_to_id'])).nil?
      reply = Reply.new(
                        issue_id: issue.id,
                        message: params["message"],
                        tweet_id: params["tweet_id"],
                        reply_to_id: params["reply_to_id"],
                        user_id: params["user_id"],
                        image_url: params["image_url"]
                        )

      if reply.save
        render status: 201
      else
        render status: 400
      end
      render status: 400
    end
  end

  def rt
    issue = self.give_relevance(params['reply_to_id'])
    if issue.save
      render status: 201
    else
      render status: 400
    end
  end

  private

  def give_relevance(reply_to_id)
    unless (issue = Issue.where(tweet_id: reply_to_id).first).nil?  
      issue.relevance += 1
      issue
    end
  end

end
