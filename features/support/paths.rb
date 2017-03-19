# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name, movie_name)
    
    begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        path_str = path_components.push('movie_path').join('_')

        if movie_name =~ /^\"(.+)\"$/
          movie_title = movie_name[1..-2]
        else movie_title = movie_name
        end
        
        movie_id = Movie.find_by title: movie_title

        case path_str
        when 'edit_movie_path'
          edit_movie_path(movie_id)
          
          #self.send(path_components.push('movie_path').join('_').to_sym)
          #rescue NoMethodError, ArgumentError
          #raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          #  "Now, go and add a mapping in #{__FILE__}"
        when 'details_movie_path'
          movie_path(movie_id)
          
        when 'Similar_Movies_movie_path'
          movie = Movie.find(movie_id)
          similar_movie_path(movie)
          
        when 'home_movie_path'
          movies_path
        end
    end
  end
end

World(NavigationHelpers)
