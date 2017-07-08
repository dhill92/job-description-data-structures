require 'json'

jobs_text = File.read(File.join(File.dirname(__FILE__), 'positions.json'))
jobs_data = JSON.parse(jobs_text)

# Who has more jobs, San Francisco or New York City?
job_counts = {
  "san francisco" => 0,
  "new york city" => 0
}

jobs_data.each do |job_data|
    if job_data["location"].downcase.include?('san francisco')
      job_counts["san francisco"]+= 1
    end
    if job_data["location"].downcase.include?('new york')
      job_counts["new york city"] += 1
    end
end


if job_counts["san francisco"] > job_counts["new york city"]
  puts "There are more jobs available in San Francisco"
elsif job_counts["new york city"] > job_counts["san francisco"]
  puts "There are more jobs available in NYC"
end

puts "There are #{job_counts["san francisco"]} jobs available in San Francisco"
puts "There are #{job_counts["new york city"]} jobs available in new york city"


# Provide a unique list of company url's from all of the postings

urls = []
jobs_data.each do |job_data|
  if !job_data["company_url"].nil? && !urls.include?(job_data["company_url"])
      urls << job_data["company_url"]
    end
end

puts urls.inspect

# How many job postings indicate a dog friendly culture?

dog_friendly = 0
jobs_data.each do |job_data|
  if job_data["description"].downcase.include?('dog-friendly') ||
    job_data["location"].downcase == 'remote' ||
    job_data["location"].downcase == 'anywhere'
    dog_friendly += 1
  end
end

puts "There are #{dog_friendly} dog friendly jobs"

# Build a hash that relates a list of companies to the number of open jobs that they have

company_job_count = {}

jobs_data.each do |job_data|
  if company_job_count[job_data["company"]].nil?
    company_job_count[job_data["company"]] = 0
  end
  company_job_count[job_data["company"]] += 1
end

puts company_job_count.inspect

buzzword = {
  "solution" => 0,
  "requirements" => 0,
  "success" => 0,
  "integral" => 0,
  "self-starter" => 0,
  "hackathons" => 0
}

jobs_data.each do |job_data|
  if job_data["description"].downcase.include?('solution')
    buzzword["solution"] += 1
  end
  if job_data["description"].downcase.include?('requirements')
    buzzword["requirements"] += 1
  end
  if job_data["description"].downcase.include?('success')
    buzzword["success"] += 1
  end
  if job_data["description"].downcase.include?('integral')
    buzzword['integral'] += 1
  end
  if job_data["description"].downcase.include?('self-starter')
    buzzword["self-starter"] += 1
  end
  if job_data["description"].downcase.include?('hackathons')
    buzzword["hackathons"] += 1
  end
end

puts buzzword.inspect

#Better solution:
#buzzword = {
#  "solution" => 0,
#  "requirements" => 0,
#  "success" => 0,
#  "integral" => 0,
#  "self-starter" => 0,
#  "hackathons" => 0
# }

# jobs_data.each do |job_data|
#   buzzword.each do |word, frequency|
#  if job_data["description"].downcase.include(word)
#   buzzword[word] += 1
#     end
#   end
# end

# Build a hash that relates the type of role to the number of open positions for that type

type_map = {}

jobs_data.each do |job_data|
  if type_map[job_data["type"]].nil?
    type_map[job_data["type"]] = 0
  end
  type_map[job_data["type"]] += 1
end

puts type_map.inspect


city_map = {}

city_map_titles_only = {}

jobs_data.each do |job_data|
  if city_map[job_data["location"]].nil?
    city_map[job_data["location"]] = []
  end
  if city_map_titles_only[job_data["location"]].nil?
    city_map_titles_only[job_data["location"]] = []
  end

  city_map[job_data["location"]] << job_data
  city_map_titles_only[job_data["location"]] << job_data["title"]
end

puts city_map.inspect
puts city_map_titles_only.inspect
#job_locations = {}

#jobs_data.each do |job_data|
#  if job_locations[job_data["location"]].nil?
#    job_locations[job_data["location"]] = 0
#  end
#  job_locations[job_data["location"]] += 1
#end

#puts job_locations.inspect

# How many jobs are remote?
# Who has more jobs, San Francisco or New York City?
# Provide a unique list of company url's from all of the postings
# How many job postings indicate a dog friendly culture?
# Build a hash that relates a list of companies to the number of open jobs that they have
# Buzzword count: build a hash that relates "solution", "requirements", "success", "integral", "self-starter", and "hackathons" to how often they are found in all of the job descriptions
# Build a hash that relates the type of role to the number of open positions for that type
# Build a hash that relates a location to its list of open jobs
