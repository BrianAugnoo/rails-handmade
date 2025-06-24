class SearchController < ApplicationController
  def search_user
    result = Search.user(params[:query], current_user)
    @ordered_conversation = result[:existing_conversation]
    @other_user = result[:inexsting_conversation]
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace(
          "search-conversation",
          partial: "search/ordered_conversation",
          locals: { conversations: @ordered_conversation, current_user: current_user }
          ),
          turbo_stream.replace(
          "search-user",
          partial: "search/ordered_user",
          locals: { conversation: Conversation.new, users: @other_user, no_limit: false }
          )
        ]
      end
      format.html { redirect_to root_path }
    end
  end

  def results
    users = Search.all_users(params[:query])
    arts = Search.arts(params[:query])

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream:
          turbo_stream.replace(
            "results",
            partial: "search/result",
            locals: { users: users, arts: arts }
          )
      end
      format.html { redirect_to root_path }
    end
  end

  def user_index
    @users = []
    params[:users].each do |user_id|
      @users << User.find(user_id)
    end
    @conversation = Conversation.new
  end
end
