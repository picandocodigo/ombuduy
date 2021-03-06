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
      render text: "Error", status: 400
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
        render text: "OK", status: 201
      else
        render text: reply.errors, status: 400
      end
    else
      render text: "Error", status: 400
    end
  end

  def rt
    unless (issue = give_relevance(params['tweet_id'])).nil?
      if issue.save
        render text: "OK", status: 201
      else
        render text: issue.errors, status: 400
      end
    else
      render text: "Error", status: 400
    end
  end

  private

  def give_relevance(tweet_id)
    unless (issue = Issue.where(tweet_id: tweet_id).first).nil?
      issue.relevance ||= 0
      issue.relevance += 1
      issue
    end
  end

end
