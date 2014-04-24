require 'open-uri'

class TrailController < ApplicationController
  
  def index         
    page = Nokogiri::HTML(open("http://www.morcmtb.org/forums/trailconditions.php"))
    rows = page.css('table.forumbits').css('tr')
    
    @trail_hash = Hash.new

    rows.each do |r|
      if r.css('td')[0].children.children.text != "Trail"
        trail = r.css('td')[0].children.children.text
        
        condition = r.css('td')[1].children.children.text
        desc = r.css('td')[3].children.text
        
        @trail_hash.merge!(trail => [condition, desc])
      end
    end

  
  
  end

end
