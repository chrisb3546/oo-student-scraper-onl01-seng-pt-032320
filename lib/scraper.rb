require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    student_array = []
    doc.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        
        student_location = student.css(".student-location").text
        student_name = student.css(".student-name").text
        profile_url =  "#{student.attr('href')}"
        
        # binding.pry
        student_array << {name: student_name, location: student_location, profile_url: profile_url}
      end
     
   
    end
   student_array
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    links = doc.css(".social-icon-container").children.css("a").map do |platform|
      
      student_platform = "#{platform.attr('href')}"
      end
      student_hash = {}
      links.each do |link| 
        # binding.pry
        if link.include?("twitter")
          student_hash[:twitter] = link 
        elsif link.include?("linked")
          student_hash[:linkedin] = link
        elsif link.include?("github")
          student_hash[:github] = link
         else 
          student_hash[:blog] = link
        #  student_hash
          end
           student_hash[:profile_quote] = doc.css(".profile-quote").text
            student_hash[:bio] = doc.css(".description-holder").children.css("p").text
          #  binding.pry
  end
  student_hash
  # binding.pry
end

end



# #### The `.scrape_profile_page` Method

# This is a class method that should take in an argument of a student's profile
# URL. It should use Nokogiri and Open-URI to access that page. The return value
# of this method should be a hash in which the key/value pairs describe an
# individual student. Some students don't have a Twitter or some other social
# link. Be sure to be able to handle that. Once written, the following code
# should return a hash containing info from the provided `profile_url`:

# ```ruby
# Scraper.scrape_profile_page(profile_url)
# ```

# And the returned hash should look like the following:

# ```ruby
# {
#   :twitter=>"http://twitter.com/flatironschool",
#   :linkedin=>"https://www.linkedin.com/in/flatironschool",
#   :github=>"https://github.com/learn-co",
#   :blog=>"http://flatironschool.com",
#   :profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
#   :bio=> "I'm a school"
# }
# ```

# The only attributes you need to scrape from a student's profile page are the
# ones listed above: the Twitter URL, LinkedIn URL, GitHub URL, blog URL, profile
# quote, and bio. The hash you build using those attributes should be formatted
# like the one in the example above.

# **Why class methods?**

# Why are our scraping methods being defined as class methods? Well, we don't need
# to store any information about the `Scraper` once it has completed the job of
# scraping. We simply need to scrape some information and pass that information
# along to our `Student` class. So, we don't need to produce instances of
# `Scraper` that maintain their own attributes.


