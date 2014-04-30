class TrailController < ApplicationController
  
  def index         
    @trails = Trail.order(:name)
  end

end
