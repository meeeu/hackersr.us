class PagesController < ApplicationController
  def home
    if signed_in?
      @title = "Home"
      render 'home1'
    end
  end

  def home1
    @title = "Home"
  end

  def contact
    @title = "Contact"
  end

  def about
    @title = "About"
  end

end
