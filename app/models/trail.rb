require 'nokogiri'
require 'open-uri'

class Trail < ActiveRecord::Base


  def self.scrape 
    puts "---------------------------------------"
    puts "--------------Updating...--------------"
    puts "---------------------------------------"
    
    page = Nokogiri::HTML(open("http://www.morcmtb.org/forums/trailconditions.php"))
    rows = page.css('table.forumbits').css('tr')

    rows.each do |r|
      if r.css('td')[0].children.children.text != "Trail"
        name = r.css('td')[0].children.children.text.to_s
        condition = r.css('td')[1].children.children.text.to_s
        desc = r.css('td')[3].children.text.to_s
        date_time_array = r.css('td')[5].children.children.text.to_s.gsub(/[^a-zA-Z0-9: -]/, "").split(' ')
        
        date_array = date_time_array[0].split[0].split('-')
        date_string = (date_array[2] + "-" + date_array[0] + "-" + date_array[1]).to_s
        time_string = date_time_array[1].to_s                                        
        tod_string = date_time_array[2].to_s

        date = (date_string + " " + time_string + " " + tod_string).to_datetime
        
        if t = Trail.where(:name => name)[0]
          t.update_attributes!(:name => name, :condition => condition, :desc => desc, :date => date, :updated_at => DateTime.now)
        else
          t = Trail.new
          t.name = name
          t.condition = condition
          t.desc = desc
          t.date = date
          t.save!
        end
      end
    end

    puts "---------------------------------------"
    puts "------------Update Complete------------"
    puts "---------------------------------------" 
  end
end
