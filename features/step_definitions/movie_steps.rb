Given /^the following movies exist:$/ do |data_table|
	data_table.hashes.each do |movie|
		Movie.create!(movie)
	end
end

Given /^(?:|I )am on (.+) for (.+)$/ do |page_name, movie_name|
	visit path_to(page_name, movie_name)
end

When /^(?:|I )go to (.+) for (.+)$/ do |page_name, movie_name|
	visit path_to(page_name, movie_name)
end

When /^(?:|I )press "([^"]*)"$/ do |button|
	click_button(button)
end

When /^(?:|I )follow "([^"]*)"$/ do |link|
	click_link(link)
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
	fill_in(field, :with => value)
end

When /^(?:|I )fill in "([^"]*)" for "([^"]*)"$/ do |value, field|
	fill_in(field, :with => value)
end

Then /^(?:|I )should see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end

Then /^(?:|I )should not see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_no_content(text)
  else
    assert page.has_no_content?(text)
  end
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |movie_name, director|
   page.should have_content("Details about #{movie_name}")
   page.should have_content("Director: #{director}")
end

Then /^(?:|I )should be on (.+)$/ do |arg|
  split_arg = arg.split("\sfor\s")
  
  if split_arg.length > 1
  	page_name = split_arg[0]
  	movie_name = split_arg[1][1..-2]
  else
  	page_name = split_arg[0]
  	movie_name = ""
  end

  current_path = URI.parse(current_url).path
  
  path_to(page_name, movie_name)
  
  if current_path.respond_to? :should
    current_path.should == path_to(page_name, movie_name)
  else
    assert_equal path_to(page_name, movie_name), current_path
  end
end