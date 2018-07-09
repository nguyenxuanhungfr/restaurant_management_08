class StaticPagesController < ApplicationController
  before_action :load_menu, only: :home

  def home; end
end
