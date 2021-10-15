# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create(movie)
  end
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  
  if !(e1.in?(page.body)) or !(e2.in?(page.body))
    fail "Condition not met"
  end

  e1_idx = page.body.index(e1)
  e2_idx = page.body.index(e2)
  
  if !(e1_idx < e2_idx)
    fail "Condition not met"
  end
  
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  
  rating_list.split(',').each do |option|
    
    rating = "ratings[#{option.strip}]"
    
    if uncheck
      uncheck(rating)
    else
      check(rating)
    end
    
  end

end

Then /I should see all the movies/ do
  
  Movie.all.each do |movie|
    
    step "I should see \"#{movie.title}\""
  
  end
  
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |title, director|
  movie = Movie.find_by_title(title)
  assert movie.director == director, "#{title} director is #{movie.director} and it should be #{director}"
end

Then /I should see the following movies: (.*)$/ do |movies_list|
  movies = movies_list.split(', ')
  movies.each do |movie|
    expect(page).to have_content(movie)
  end
end

Then /I should not see the following movies: (.*)$/ do |movies_list|
  movies = movies_list.split(', ')
  movies.each do |movie|
    expect(page).to have_no_content(movie)
  end
end