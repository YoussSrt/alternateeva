# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Cleaning existing data
Place.destroy_all

places = [
  {
    name: "Ground Control",
    description: "Ancien centre de tri postal transformé en lieu de vie hybride. Un espace de 4500m² dédié à la culture, à la restauration responsable et aux initiatives positives.",
    city: "Paris",
    address: "81 Rue du Charolais, 75012",
    category: "Tiers-lieu",
    website: "https://www.groundcontrolparis.com",
    tags: "food, culture, coworking, événements"
  },
  {
    name: "La Recyclerie",
    description: "Ancienne gare réhabilitée en tiers-lieu écologique avec café-cantine, atelier de réparation, ferme urbaine et programmation engagée.",
    city: "Paris",
    address: "83 Boulevard Ornano, 75018",
    category: "Lieu écologique",
    website: "https://www.larecyclerie.com",
    tags: "écologie, café, agriculture urbaine, zéro-déchet"
  },
  {
    name: "Le Hasard Ludique",
    description: "Ancienne gare de la Petite Ceinture reconvertie en lieu culturel alternatif proposant concerts, spectacles et ateliers dans un cadre atypique.",
    city: "Paris",
    address: "128 Avenue de Saint-Ouen, 75018",
    category: "Espace culturel",
    website: "https://www.lehasardludique.paris",
    tags: "musique, spectacles, culture, bar"
  },
  {
    name: "La Cité Fertile",
    description: "Laboratoire de la ville durable installé dans une ancienne gare de marchandises. Un hectare d'expérimentations urbaines et de découvertes.",
    city: "Pantin",
    address: "14 Avenue Edouard Vaillant, 93500",
    category: "Tiers-lieu",
    website: "https://www.citefertile.com",
    tags: "écologie, culture, innovation, agriculture urbaine"
  },
  {
    name: "Le Pavillon des Canaux",
    description: "Maison-café au bord de l'eau proposant une cuisine maison, des espaces de coworking et une programmation culturelle variée.",
    city: "Paris",
    address: "39 Quai de la Loire, 75019",
    category: "Café créatif",
    website: "https://www.pavillondescanaux.com",
    tags: "café, coworking, culture, restauration"
  },
  {
    name: "La Station - Gare des Mines",
    description: "Friche culturelle dédiée aux cultures électroniques et alternatives, lieu d'expérimentation artistique et de fête.",
    city: "Paris",
    address: "29 Avenue de la Porte d'Aubervilliers, 75018",
    category: "Friche culturelle",
    website: "https://www.lastation.paris",
    tags: "musique, culture, art, underground"
  }
]

# Creating places
places.each do |place|
  Place.create!(place)
end

puts "Created #{Place.count} places"
