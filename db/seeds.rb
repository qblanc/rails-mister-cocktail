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
  if ingredient['ingredients'].nil?
    next
  else
    ingredient['ingredients'].each do |ingredient_name|
      Ingredient.create!(name: ingredient_name['strIngredient'])
    end
  end
end
puts 'Ingredients created'

puts 'Creating cocktails'
('a'..'b').to_a.each do |letter|
  url = "https://www.thecocktaildb.com/api/json/v1/1/search.php?f=#{letter}"
  cocktail_list = JSON.parse(open(url).read)
  if cocktail_list['drinks'].nil?
    next
  else
    cocktail_list['drinks'].each do |cocktail|
      cock = Cocktail.create!(name: cocktail['strDrink'], description: cocktail['strInstructions'])
      ingredients = []
      quantity = []
      (1..15).to_a.each do |ref|
        if cocktail["strIngredient#{ref}"].nil?
          next
        else
          ingredients << Ingredient.find_by_name(cocktail["strIngredient#{ref}"])
          if cocktail["strMeasure#{ref}"].nil?
            quantity << ''
          else
            quantity << cocktail["strMeasure#{ref}"]
          end
        end
      end
      puts ingredients
      ingredients.each_with_index do |ingredient, index|
        Dose.create!(ingredient_id: ingredient.id, cocktail_id: cock.id, quantity: quantity[index])
      end
    end
  end
end
puts 'Cocktails created'

puts 'Finished'
