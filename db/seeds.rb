require 'open-uri'
require 'json'

puts 'Deleting ingredients...'
Ingredient.destroy_all
puts 'Ingredients deleted'

puts 'Creating ingredients...'
ingredient_ids = (1..600).to_a
ingredient_ids.each do |ingredient_id|
  url = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?iid=#{ingredient_id}"
  ingredient = JSON.parse(open(url).read)
  if ingrdient['ingredients'].!nil?
    ingredient['ingredients'].each do |ingredient_name|
      Ingredient.create!(name: ingredient_name['strIngredient'])
    end
  end
end
puts 'Ingredients created'

puts 'Finished'
