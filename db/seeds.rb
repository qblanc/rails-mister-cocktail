require 'open-uri'
require 'json'

puts 'Deleting ingredients...'
Ingredient.destroy_all
puts 'Ingredients deleted'

puts 'Creating ingredients...'
url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
ingredient_list = JSON.parse(open(url).read)
ingredient_list['drinks'].each do |ingredient|
  Ingredient.create!(name: ingredient['strIngredient1'])
end
puts 'Ingredients created'

puts 'Finished'
