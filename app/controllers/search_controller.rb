class SearchController < ApplicationController
  def search_user
    result = Search.user(params[:query], current_user)
    @ordered_conversation = result[:existing_conversation]
    @other_user = result[:inexsting_conversation]
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("search-conversation", partial: "search/ordered_conversation", locals: { conversations: @ordered_conversation, current_user: current_user })
      end
      format.html { redirect_to root_path }
    end
  end
end
