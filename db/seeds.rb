require 'open-uri'

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
puts "Cleaning database..."
Place.destroy_all

puts "Creating places..."

def attach_photos_from_urls(place, urls)
  urls.each do |url|
    file = URI.open(url, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE)
    place.photos.attach(io: file, filename: "#{place.name.parameterize}-#{SecureRandom.hex(4)}.jpg")
  end
rescue OpenURI::HTTPError => e
  puts "Couldn't attach photo for #{place.name}: #{e.message}"
end

places_data = [
  {
    name: "Ground Control",
    description: "Ancien centre de tri postal transformé en lieu de vie hybride. Un espace de 4500m² dédié à la culture, à la restauration responsable et aux initiatives positives.",
    city: "Paris",
    address: "81 Rue du Charolais, 75012",
    category: "Tiers-lieu",
    website: "https://www.groundcontrolparis.com",
    tags: "food, culture, coworking, événements",
    photo_urls: [
      "https://www.groundcontrolparis.com/wp-content/uploads/2023/05/ground-control-paris-restaurant-terrasse-scaled.jpg",
      "https://www.groundcontrolparis.com/wp-content/uploads/2023/05/ground-control-paris-restaurant-scaled.jpg",
      "https://www.groundcontrolparis.com/wp-content/uploads/2023/05/ground-control-paris-bar-scaled.jpg"
    ]
  },
  {
    name: "La Recyclerie",
    description: "Ancienne gare réhabilitée en tiers-lieu écologique avec café-cantine, atelier de réparation, ferme urbaine et programmation engagée.",
    city: "Paris",
    address: "83 Boulevard Ornano, 75018",
    category: "Lieu écologique",
    website: "https://www.larecyclerie.com",
    tags: "écologie, café, agriculture urbaine, zéro-déchet",
    photo_urls: [
      "https://www.larecyclerie.com/wp-content/uploads/2023/01/recyclerie-cafe-restaurant.jpg",
      "https://www.larecyclerie.com/wp-content/uploads/2023/01/recyclerie-ferme-urbaine.jpg",
      "https://www.larecyclerie.com/wp-content/uploads/2023/01/recyclerie-terrasse.jpg"
    ]
  },
  {
    name: "Le Hasard Ludique",
    description: "Ancienne gare de la Petite Ceinture reconvertie en lieu culturel alternatif proposant concerts, spectacles et ateliers dans un cadre atypique.",
    city: "Paris",
    address: "128 Avenue de Saint-Ouen, 75018",
    category: "Espace culturel",
    website: "https://www.lehasardludique.paris",
    tags: "musique, spectacles, culture, bar",
    photo_urls: [
      "https://www.lehasardludique.paris/wp-content/uploads/2023/01/hasard-ludique-salle.jpg",
      "https://www.lehasardludique.paris/wp-content/uploads/2023/01/hasard-ludique-terrasse.jpg",
      "https://www.lehasardludique.paris/wp-content/uploads/2023/01/hasard-ludique-bar.jpg"
    ]
  },
  {
    name: "La Cité Fertile",
    description: "Laboratoire de la ville durable installé dans une ancienne gare de marchandises. Un hectare d'expérimentations urbaines et de découvertes.",
    city: "Pantin",
    address: "14 Avenue Edouard Vaillant, 93500",
    category: "Tiers-lieu",
    website: "https://www.citefertile.com",
    tags: "écologie, culture, innovation, agriculture urbaine",
    photo_urls: [
      "https://www.citefertile.com/wp-content/uploads/2023/01/cite-fertile-exterieur.jpg",
      "https://www.citefertile.com/wp-content/uploads/2023/01/cite-fertile-jardin.jpg",
      "https://www.citefertile.com/wp-content/uploads/2023/01/cite-fertile-bar.jpg"
    ]
  },
  {
    name: "Le Pavillon des Canaux",
    description: "Maison-café au bord de l'eau proposant une cuisine maison, des espaces de coworking et une programmation culturelle variée.",
    city: "Paris",
    address: "39 Quai de la Loire, 75019",
    category: "Café créatif",
    website: "https://www.pavillondescanaux.com",
    tags: "café, coworking, culture, restauration",
    photo_urls: [
      "https://www.pavillondescanaux.com/wp-content/uploads/2023/01/pavillon-canaux-facade.jpg",
      "https://www.pavillondescanaux.com/wp-content/uploads/2023/01/pavillon-canaux-interieur.jpg",
      "https://www.pavillondescanaux.com/wp-content/uploads/2023/01/pavillon-canaux-terrasse.jpg"
    ]
  },
  {
    name: "La Station - Gare des Mines",
    description: "Friche culturelle dédiée aux cultures électroniques et alternatives, lieu d'expérimentation artistique et de fête.",
    city: "Paris",
    address: "29 Avenue de la Porte d'Aubervilliers, 75018",
    category: "Friche culturelle",
    website: "https://www.lastation.paris",
    tags: "musique, culture, art, underground",
    photo_urls: [
      "https://www.lastation.paris/wp-content/uploads/2023/01/station-exterieur.jpg",
      "https://www.lastation.paris/wp-content/uploads/2023/01/station-salle.jpg",
      "https://www.lastation.paris/wp-content/uploads/2023/01/station-terrasse.jpg"
    ]
  },
  {
    name: "Le 104",
    description: "Ancienne gare de marchandises transformée en espace culturel et de coworking.",
    city: "Paris",
    address: "104 Boulevard de la Villette, 75019",
    category: "Tiers-lieu",
    website: "https://www.le104.paris",
    tags: "culture, coworking, événements",
    photo_urls: [
      "https://images.unsplash.com/photo-1517457373958-b7bdd4587205",
      "https://images.unsplash.com/photo-1485182708500-e8f1f318ba72"
    ]
  },
  {
    name: "La Ferme du Bonheur",
    description: "Ferme urbaine et espace de coworking qui promeut l'agriculture durable et la communauté.",
    city: "Nanterre",
    address: "12 Rue de la Ferme, 92000",
    category: "Ferme urbaine",
    website: "https://www.lafermedubonheur.com",
    tags: "agriculture urbaine, coworking, communauté, durabilité",
    photo_urls: [
      "https://images.unsplash.com/photo-1517457373958-b7bdd4587205",
      "https://images.unsplash.com/photo-1485182708500-e8f1f318ba72"
    ]
  },
  {
    name: "Bercy Beaucoup",
    description: "Un espace de coworking et de création qui rassemble des entrepreneurs, des artistes et des innovateurs.",
    city: "Paris",
    address: "12 Rue de Bercy, 75012",
    category: "Café créatif",
    website: "https://www.bercybeaucoup.com",
    tags: "coworking, création, innovation, café",
    photo_urls: [
      "https://images.unsplash.com/photo-1517457373958-b7bdd4587205",
      "https://images.unsplash.com/photo-1485182708500-e8f1f318ba72"
    ]
  },
  {
    name: "La Dynamo",
    description: "Un espace de création et de diffusion artistique, accueillant des concerts, des spectacles et des expositions.",
    city: "Pantin",
    address: "6 Rue de l'Église, 93500",
    category: "Friche culturelle",
    website: "https://www.ladynamo.fr",
    tags: "musique, art, culture, underground",
    photo_urls: [
      "https://images.unsplash.com/photo-1517457373958-b7bdd4587205",
      "https://images.unsplash.com/photo-1485182708500-e8f1f318ba72"
    ]
  },
  {
    name: "Le Sample",
    description: "Espace de coworking et de création artistique situé à Bagnolet.",
    city: "Bagnolet",
    address: "1 Rue de la Liberté, 93170",
    category: "Café créatif",
    website: "https://www.lesample.com",
    tags: "coworking, création, art",
    photo_urls: [
      "https://images.unsplash.com/photo-1517457373958-b7bdd4587205",
      "https://images.unsplash.com/photo-1485182708500-e8f1f318ba72"
    ]
  },
]

places_data.each do |place_data|
  photo_urls = place_data.delete(:photo_urls)
  place = Place.create!(place_data)
  attach_photos_from_urls(place, photo_urls)
  print "."
end

puts "\nCreated #{Place.count} places with photos!"
