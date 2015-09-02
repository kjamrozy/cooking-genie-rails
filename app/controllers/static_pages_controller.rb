class StaticPagesController < ApplicationController
  def home
    flash[:active] = 'home'
  end

  def about
    flash[:active] = 'about'
  end
end
