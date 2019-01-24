class PagesController < ApplicationController
  skip_before_action :require_user

  def show
    render params[:id] || 'welcome'
  end
end
