class HomeController < ApplicationController
  def show
    @presenter = HomePresenters::ShowPresenter.new
  end
end
