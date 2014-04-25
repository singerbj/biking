class TrailController < ApplicationController
  
  def index         
    @trails = Trail.all
  end

end
