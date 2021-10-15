class Movie < ActiveRecord::Base
    def self.same_directors director
        if director.nil? or director.empty? then
            return nil
            
        else
            Movie.where(:director => director)
        end
    end
    def self.all_ratings
        %w(G PG PG-13 NC-17 R)
    end
end