class HomeController < ApplicationController
  def index
    @arts = Art.order(created_at: :desc)
  end
end
