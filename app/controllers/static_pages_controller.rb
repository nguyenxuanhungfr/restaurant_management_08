class StaticPagesController < ApplicationController
  before_action :load_menu, only: :home
  before_action :load_type_table
  def home; end
end
