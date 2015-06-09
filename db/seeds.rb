# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

science = Category.create(title: 'Science Fiction')
thriller = Category.create(title: 'Thriller')
comedy = Category.create(title: 'Comedy')
action = Category.create(title: 'Action')

Video.create(title: 'Inception', 
            description: 'Very cool movie',
            small_cover_url: '/tmp/inception_small.jpg',
            large_cover_url: '/tmp/inception_large.jpg',
            category: science)
Video.create(title: 'Interstellar', 
            description: 'Very cool movie', 
            small_cover_url: '/tmp/interstellar_small.jpg', 
            large_cover_url: '/tmp/interstellar_large.jpg', 
            category: science)
Video.create(title: 'Interstellar', 
            description: 'Very cool movie', 
            small_cover_url: '/tmp/interstellar_small.jpg', 
            large_cover_url: '/tmp/interstellar_large.jpg', 
            category: science)
Video.create(title: 'Interstellar', 
            description: 'Very cool movie', 
            small_cover_url: '/tmp/interstellar_small.jpg', 
            large_cover_url: '/tmp/interstellar_large.jpg', 
            category: science)
Video.create(title: 'Interstellar', 
            description: 'Very cool movie', 
            small_cover_url: '/tmp/interstellar_small.jpg', 
            large_cover_url: '/tmp/interstellar_large.jpg', 
            category: science)
Video.create(title: 'Interstellar', 
            description: 'Very cool movie', 
            small_cover_url: '/tmp/interstellar_small.jpg', 
            large_cover_url: '/tmp/interstellar_large.jpg', 
            category: science)
Video.create(title: 'Interstellar', 
            description: 'Very cool movie', 
            small_cover_url: '/tmp/insidious_small.jpg', 
            large_cover_url: '/tmp/interstellar_large.jpg', 
            category: science,
            created_at: 1.day.ago)


Video.create(title: 'Mission Impossible 3', 
            description: 'Very cool movie', 
            small_cover_url: '/tmp/MI3_small.jpg',
            large_cover_url: '/tmp/MI3_large.jpg', 
            category: action)
Video.create(title: 'Insidious', 
            description: 'Very cool movie', 
            small_cover_url: '/tmp/insidious_small.jpg', 
            large_cover_url: '/tmp/insidious_large.jpg', 
            category: thriller)
Video.create(title: 'Monk', 
            description: 'Very cool movie', 
            small_cover_url: '/tmp/monk_small.jpg', 
            large_cover_url: '/tmp/monk_large.jpg', 
            category: comedy)














